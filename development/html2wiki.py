#! /usr/bin/python3
'''
Created on 30.11.2014

@author: hm
'''

import os.path, sys, re

def log(msg):
    '''Writes a given message to stdout.
    @param msg:    the message to write
    '''
    sys.stdout.write(msg + "\n");
def error(msg):    
    '''Writes a given message to stderr.
    @param msg:    the message to write
    '''
    sys.stderr.write("+++ " + msg + "\n");
    
class ParseState:
    '''Stores the state while the parsing process
    '''
    def __init__(self, tag):
        self._tag = tag
        self._innerClass = None
        self._listLevel = 0
        self._removeNewlines = True
        self._breakLines = True
        self._textOutside = False
        self._startLine = 0
        self._endLine = 0
        self._prefixList = None
        self._attributes = None
    
class StackOfParseState:
    '''Maintains a stack of parser states.
    At the begin of each tag the state will be pushed and at the end this
    state will be restored.
    '''
    def __init__(self, document):
        '''Constructor.
        @param document: the parent of the stack
        '''
        self._stack = []
        self._document = document
        
    def push(self, tag):
        '''Pushes a new created state.
        @param tag:    the tag belonging to the state
        @return:        the new state (top of stack)
        '''
        rc = ParseState(tag)
        self._stack.append(rc)
        return rc

    def indexOfTag(self, tag):
        '''Finds the largest index of a stack entry with the given tag.
        @param tag:    tag to find
        @return:    -1: tag not found<br>
                    otherwise: the highest index of all entries with the tag
        '''
        ix = len(self._stack) - 1
        while ix >= 0:
            if self._stack[ix]._tag == tag:
                break
            ix -= 1
        return ix
        
    def pop(self, tag, state):
        '''Pops a state.
        @param tag: the expected tag. If the top of stack has another tag
                    the stack will be reduced until the expected tag.
                    But only if tag marks a block
        @return:    None: no entry with the given tag found<br>
                    otherwise: the the top of stack after the pop operation 
        '''
        rc = None
        searchedIsBlock = self._document.isBlock(tag)
        ixTag = self.indexOfTag(tag)
        if ixTag < 0:
            error("{:s}-{:d}: missing opening tag for </{:s}>".format( 
                  self._document._fnInput, state._endLine, tag))
        if ixTag >= 0 or not searchedIsBlock:
            while len(self._stack) > 0:
                current = self._stack.pop()
                if current._tag == tag:
                    break
                else:
                    error("{:s}-{:d}: missing opening tag for <{:s}> in line {:d}" 
                          .format(self._document._fnInput, state._endLine, tag,
                          current._startLine))
                    self._document.handleTagEnd(current._tag, current)
                    currentIsBlock = self._document.isBlock(current._tag)
                    if currentIsBlock or not searchedIsBlock:
                        break
        if len(self._stack) > 0:
            rc = self._stack[len(self._stack) - 1]
        return rc
        
class Document:
    '''Maintains a HTML document.
    '''
    def __init__(self, filename):
        '''Constructor.
        @param filename: the name of the document.
        '''
        self._fnInput = filename
        self._fnOutput = None
        if filename != None:
            if filename.endswith(".htm"):
                self._fnOutput = filename.replace(".htm", ".wiki")
            else:
                self._fnOutput = filename + ".wiki"
        self._lines = []
        self._headerLines = 0
        self._footerLines = 0
        self._fpOut = None
        self._blockEndReached = True
        self._blockEndText = None
        if self._fnOutput != None:
            self._fpOut = open(self._fnOutput, "w")
            self._fpOut.write("<!--mediawiki-->\n")
        self._patternBlockTags = re.compile(r'(div|ol|ul|li)$', re.IGNORECASE)
        self._patternNotSpace = re.compile(r'\S')
        self._patternHRef = re.compile(r'href="([^"]+)"', re.IGNORECASE)
        self._patternAbsoluteUrl = re.compile(r'(https?|ftp):')
        self._patternSrc = re.compile(r'src="([^"]+)"', re.IGNORECASE)
        self._patternTitle = re.compile(r'title="([^"]+)"', re.IGNORECASE)
        self._patternAlt = re.compile(r'alt="([^"]+)"', re.IGNORECASE)
        self._outBuffer = ""
        self._outLines = []
        self._wrapLength = 72
        self._preWrap = None
        self._postWrap = None
        self._removeTopOfLineBlanks = False
    
    def setWrapSettings(self, preWrapChars, postWrapChars):
        '''Set the settings for line wrapping.
        @param preWrapChars    the characters which initiates a wrapping above
        @param postWrapChars   the characters which initiates a wrapping behind
        '''
        self._preWrap = re.compile(r'[^' + preWrapChars + ']([' + preWrapChars + ']+)')
        self._postWrap = re.compile(r'([' + postWrapChars + r']+)' )

    def isBlock(self, tag):
        '''Returns whether a tag belongs to a block tag.
        @param tag:  tag to test
        @return:     True: the tag is a block tag<br>
                     False: otherwise
        '''
        rc = self._patternBlockTags.match(tag) != None
        return rc
    
    def isEmpty(self, text):
        '''Tests whether the text is empty (has no not whitespace.
        @param text:    text to test
        @return:        True: no relevant text<br>
                        False: the text has non-white-space(s)
        '''
        rc = self._patternNotSpace.search(text) == None if text != None else True
        return rc

    def getHRef(self, attr):
        '''Extracts the href info from the attributes.
        @param attr:    attributes to inspect
        @return:       the url of the href="url" definition
        '''
        matcher = self._patternHRef.search(attr)
        rc = matcher.group(1) if matcher != None else ""
        return rc

    def getSrc(self, attr):
        '''Extracts the src info from the attributes.
        @param attr:    attributes to inspect
        @return:       the URL of the src="URL" definition
        '''
        matcher = self._patternSrc.search(attr)
        rc = matcher.group(1) if matcher != None else ""
        return rc

    def getTitle(self, attr):
        '''Extracts the title info from the attributes.
        @param attr:   attributes to inspect
        @return:       None: no title available<br>
                       otherwise: the TITLE of the title="TITLE" definition
        '''
        matcher = self._patternTitle.search(attr)
        rc = matcher.group(1) if matcher != None else None
        return rc

    def getAlt(self, attr):
        '''Extracts the alternative info from the attributes.
        @param attr:    attributes to inspect
        @return:       None: no alternative text available<br>
                       otherwise: the ALT info of the alt="ALT" definition
        '''
        matcher = self._patternAlt.search(attr)
        rc = matcher.group(1) if matcher != None else ""
        return rc

    def isAbsoluteUrl(self, url):
        '''Tests whether the URL is an absolute url.
        Note: a relative url link to another page of the same site.
        @param url:    the URL to test
        @return:       True: the URL links to another site<br>
                       False: the URL links to the same site
        '''
        rc = self._patternAbsoluteUrl.match(url) != None
        return rc
    
    def destroy(self):
        '''Releases the resources.
        '''
        if self._fpOut != None:
            self._fpOut.close()
            self._fpOut = None
        
    def readLines(self):
        '''Read the file into a list of lines.
        '''
        fp = open(self._fnInput, "r")
        for line in fp:
            self._lines.append(line)
        fp.close()
      
    def extractContent(self):
        '''Extracts the content without header and footer.
        '''
        ix = -1
        for line in self._lines:
            ix += 1
            if line.find('id="main-page"') >= 0:
                break
        self._lines = self._lines[ix+1:]
        self._headerLines = ix + 1
        ix = len(self._lines)
        countDivs = 0
        while ix > 0 and countDivs < 2:
            ix -= 1
            if self._lines[ix].find("</div>") >= 0:
                countDivs += 1
        self._footerLines = len(self._lines) - ix      
        self._lines = self._lines[:ix]   
        self._paragraphs = []
    
    def translateText(self, text, state):
        '''Converts HTML text into "raw" text, e.g. &amp; is converted to &
        @param text:    text to convert
        @param state:   the parser state
        @return:        the text without HTML meta symbols
        '''
        text = text.replace('&lt;', '<').replace('&gt;', '>')
        text = text.replace('&amp;', '&').replace("\t", ' ')
        if state._removeNewlines:
            text = text.replace("\n", ' ')
        while text.find('  ') >= 0:
            text = text.replace('  ', ' ')
        return text
    
    def outText(self, text, state):
        '''Converts HTML meta symbols into "normal" text and put it to the file.
        @param text:    text to convert
        @param state:   the parser state
        '''
        text = self.translateText(text, state)
        self.out(text, state)

    def getAndClearOutText(self, state):
        '''Gets the collected output text, convert it and clear the collection.
        @param state:   the parser state
        @return: the collected text (_outLines + outBuffer), converted to raw text
        '''
        rc = "".join(self._outLines) + self._outBuffer
        rc = self.translateText(rc, state)
        self._outLines.clear()
        self._outBuffer = ""
        return rc   
        
    def parse(self, body):
        '''Parses the html text.
        Search for HTML tags and call the translation methods of these elements.
        '''
        body = re.sub(r'<!--\[if lt IE 10\][^\]]+?endif\]-->', '', body)
        stack = StackOfParseState(self)
        patternTag = re.compile(r'<(/)?(\w+)([^>]*?)(\s*/\s*)?>')
        # the following state is not part of the stack
        # it will be not used in correct syntax (no text outside of tags)
        state = ParseState("div")
        lineNo = self._headerLines
        while body != "":
            matcher = patternTag.search(body)
            if matcher == None:
                self.outText(body, state)
                body = ""
            else:
                text = body[0:matcher.start(0)]
                lineNo += text.count("\n")
                body = body[matcher.end(0):]
                if not self.isEmpty(text):
                    self.outText(text, state)
                isEnd = matcher.group(1) != None
                tag = matcher.group(2).lower()
                if isEnd:
                    state._endLine = lineNo
                    self.handleTagEnd(tag, state)
                    state = stack.pop(tag, state)
                    if state == None:
                        state = ParseState(tag)
                else:
                    newState = stack.push(tag)
                    self.deriveState(state, newState)
                    state = newState
                    state._startLine = lineNo
                    attr = matcher.group(3)
                    if attr != None:
                        lineNo += attr.count("\n")
                    self.handleTagStart(tag, state, attr)
                    # <TAG/>?
                    if matcher.group(4) != None:
                        state._endLine = lineNo
                        self.handleTagEnd(tag, state)
                        state = stack.pop(tag, state)
                    elif tag == 'pre':
                        # ignore all '<' until '</pre>':
                        ix = body.find("</pre>")
                        if ix < 0:
                            text = body
                            body = ""
                        else:
                            text = body[0:ix]
                            body = body[ix:]
                        self.out(text, state)

    def deriveState(self, oldState, newState):
        '''Derives some data from the prior state.
        @param oldState:    the prior state
        @param newState:    the current state
        '''
        if newState == None or oldState == None:
            pass
        else:
            newState._prefixList = oldState._prefixList
            newState._listLevel = oldState._listLevel
        
    def endOfBlock(self, state):
        '''Handles the end of a block tag.
        @param state:   the parser state
        '''
        if not self._blockEndReached:
            # avoid too many newlines after a line wrap (aligned to the line end):
            value = self._blockEndText if self._blockEndText != None else ""
            if value.startswith("\n") and len(self._outBuffer) == 0:
                value = value[1:]
            self.out(value, state)
            self.outFlush()
            self._blockEndReached = True
           
    def handleTagStart(self, tag, state, attr):
        '''Handles the start tag, e.g. div
        @param tag:    the tag name
        @param state:  the current parser state
        @param attr:   the attributes of the tag
        '''
        if attr == None:
            attr = ""
        state._attributes = attr
        if tag == "div" or tag == "p":
            self.onDiv(state, attr)
        elif tag[0] == 'h' and tag[1].isdigit():
            self.endOfBlock(state)
            self.onHx(state, attr)
        elif tag == "pre":
            self.endOfBlock(state)
            state._removeNewlines = False
            self.onPre(state, attr)
        elif tag == "ol":
            self.endOfBlock(state)
            state._listLevel += 1
            self.onOl(state, attr)
        elif tag == "ul":
            self.endOfBlock(state)
            state._listLevel += 1
            self.onUl(state, attr)
        elif tag == "li":
            self.onLi(state, attr)
        elif tag == "b" or tag == "strong":
            self.onB(state, attr)
        elif tag == "i":
            self.onI(state, attr)
        elif tag == "span":
            self.onSpan(state, attr)
        elif tag == "a":
            self.onA(state, attr)
        elif tag == "img":
            self.onImg(state, attr)
        else:
            error("{:s}-{:d}: unknown tag: {:s}".format(
                self._fnInput, state._startLine, tag))
            self.onGeneric(state, attr)
            
          
    def handleTagEnd(self, tag, state):
        '''Handles an end tag, e.g. /div
        @param tag:    the tag name
        @param state:  the current parser state
        '''
        if tag == 'div' or tag == 'p':
            self.endOfBlock(state)
            self.onDiv(state, None)
        elif tag[0] == 'h' and tag[1].isdigit():
            self.endOfBlock(state)
            self.onHx(state, None)
        elif tag == 'pre':
            self.endOfBlock(state)
            self.onPre(state, None)
        elif tag == 'ol':
            self.endOfBlock(state)
            state._listLevel += 1
            self.onOl(state, None)
        elif tag == 'ul':
            self.endOfBlock(state)
            state._listLevel -= 1
            self.onUl(state, None)
        elif tag == 'li':
            self.endOfBlock(state)
            self.onLi(state, None)
        elif tag == 'b' or tag == 'strong':
            self.onB(state, None)
        elif tag == 'i':
            self.onI(state, None)
        elif tag == 'span':
            self.onSpan(state, None)
        elif tag == 'a':
            self.onA(state, None)
        elif tag == 'img':
            self.onImg(state, None)
        elif tag == 'br':
            self.onBr(state, None)
        else:
            self.onGeneric(state, None)
                      
    def convert(self):
        '''Converts the HTML input into Mediawiki syntax.
        '''
        self.readLines()
        self.extractContent()
        self.parse("".join(self._lines))
     
    def out(self, text, state):
        '''Writes a text to the output file.
        @param text:    the text to write
        '''
        self._blockEndReached = False
        self._outBuffer += text
        if state._breakLines:
            rest = self._outBuffer
            maxIx = len(rest) + 1
            while len(rest) > self._wrapLength:
                tail = rest[self._wrapLength - 2:]
                matcherPre = self._preWrap.search(tail)
                matcherPost = self._postWrap.search(tail)
                if matcherPre == None and matcherPost == None:
                    while self._removeTopOfLineBlanks and rest.startswith(' '):
                        rest = rest[1:]
                    self._outLines.append(rest + "\n")
                    rest = ""
                    break
                else:
                    # 2**31-1:
                    ix = maxIx
                    if matcherPre != None:
                        ix = matcherPre.start(1) - 1
                    if matcherPost != None:
                        ix = min(ix, matcherPost.end(1))
                    ix += self._wrapLength - 1
                    value = rest[0:ix]
                    while self._removeTopOfLineBlanks and value.startswith(' '):
                        value = value[1:]
                    self._outLines.append(value + "\n")
                    rest = rest[ix:]
            while self._removeTopOfLineBlanks and rest.startswith(' '):
                rest = rest[1:]
            self._outBuffer = rest       
            
        
    def outFlush(self):
        '''Writes the text to the output file.
        @param text:    None: _outBuffer will be written<br>
                        otherwise: the text to write
        '''
        if self._fpOut != None:
            if len(self._outLines) > 0:
                for line in self._outLines:
                    self._fpOut.write(line)
            self._fpOut.write(self._outBuffer)
        self._outLines.clear()
        self._outBuffer = ""
           

class MediaWikiConverter (Document):
    '''Implements the conversion to MediaWiki syntax
    '''
    def __init__(self, filename):
        '''Constructor.
        @param filename:    None or the name of the HTML file
        '''
        version = sys.version_info
        if version < (3, 0):
            super(MediaWikiConverter, self).__init__(filename)
        else:
            super().__init__(filename)
        self._removeTopOfLineBlanks = True
        # " wrap behind: !$%?>,;.:)}|*]\n  wrap above:  \t \&/=<-+#~{[{
        # note: |* # are wiki meta symbols at top of line:
        self.setWrapSettings(r'|\\&/=<+#~{\[{\t ', r'-+>!$%?>,;.:)}\]|*\n')
        self._patternDivClass = re.compile('<div class="([^"]+)"></div>\n$')

    def handleAttributes(self, state, attr):
        '''Handles class and id for tags which don't have class or id.
        This is necessary for paragraphs to save labels (id="") and classes.
        @param state:   the current parser state
        @param attr:    attributes of the tag
        '''
        if attr.find('id="') >= 0 or attr.find('class="') >= 0:
            self.out("<div" + attr + " />\n", state)

    def onDiv(self, state, attr):
        '''Handles a DIV start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.handleAttributes(state, attr)
            self._blockEndText = "\n\n"
     
    def onHx(self, state, attr):
        '''Handles a headline start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.handleAttributes(state, attr)
            frame = "=" * (ord(state._tag[1]) - ord('0'))
            self.out(frame + ' ', state)
            self._blockEndText = " " + frame + "\n"
     
    def onOl(self, state, attr):
        '''Handles an ordered list start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.handleAttributes(state, attr)
            state._prefixList = "#" * state._listLevel
            self._blockEndText = ""
        
    def onUl(self, state, attr):
        '''Handles an unordered list start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.handleAttributes(state, attr)
            state._prefixList = "*" * state._listLevel
            self._blockEndText = ""
        
    def onLi(self, state, attr):
        '''Handles a list item start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.out(state._prefixList, state)
            self._blockEndText = "\n"

    def onPre(self, state, attr):
        '''Handles a pre section start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.out("<pre" + attr + ">", state)
            self._blockEndText = "</pre>\n"
        
    def onB(self, state, attr):
        '''Handles a bold start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        self.out("'''", state)
        
    def onI(self, state, attr):
        '''Handles an italic start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        self.out("''", state)
        
    def onSpan(self, state, attr):
        '''Handles an italic start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.out("<span" + attr + ">", state)
        else:
            self.out("</span>", state)
     
    def onA(self, state, attr):
        '''Handles an anchor start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.outFlush()
        else:
            linkText = self.getAndClearOutText(state)
            href = self.getHRef(state._attributes)
            if self.isAbsoluteUrl(href):
                self.out("[{:s} {:s}]".format(href, linkText), state)
            else:
                self.out('[[{:s}|{:s}]]'.format(href, linkText), state)
     
    def onImg(self, state, attr):
        '''Handles an image.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            url = self.getSrc(state._attributes)
            title = self.getTitle(state._attributes)
            alt = self.getAlt(state._attributes)
            args = url
            # transfer the class from the outer div:
            matcher = self._patternDivClass.search(self._outBuffer)
            if matcher != None:
                args += "|class=" + matcher.group(1)
                self._outBuffer = self._outBuffer[0:matcher.start(0)]
            if alt != None:
                args += '|alt=' + alt
            if title != None:
                args += '|' + title
            self.out('[[{:s}]]'.format(args), state)
     
    def onBr(self, state, attr):
        '''Handles a line break.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        if attr != None:
            self.out("<br/>")
     
    def onGeneric(self, state, attr):
        '''Handles an italic start or end.
        @param state: the current parser state
        @param attr:  None: end of tag is reached<br>
                      otherwise: the tag attributes, e.g. class
        '''
        tag = state._tag
        if attr == None:
            self.out("</{:s}".format(tag))
        else:
            if attr != "" and not attr.startswith(' '):
                attr = ' ' + attr
            self.out("<{:s}{:s}>".format(tag, attr))
     
       
def usage(err):
    '''Writes a usage message and stopps the program.
    '''
    log("""Usage: html2wiki <file1> [<file2>]
""")
    if err != None:
        error(err)
    sys.exit(1)
  
def main(argv):
    '''The main program.
    @param argv the arguments (without program name).
    '''
    for item in argv:
        if not os.path.exists(item):
            error("file not found: " + item)
        else:
            doc = MediaWikiConverter(item)
            doc.convert()
            doc.destroy()

      
if __name__ == '__main__':
    main(sys.argv[1:])