'''
Created on 03.02.2013

@author: hm
'''
import os, re, codecs
from webbasic.sessionbase import SessionBase

from util.util import Util

class Session(SessionBase):
    '''
    classdocs
    '''

    def __init__(self, request, application):
        '''
        Constructor.
        @param request: the HTTP request info
        @param application: the name of the application. Will be used while 
                            searching the configuration file
        '''
        super(Session, self).__init__(request,
            ['de', 'en', 'it', 'pl', 'pt-br', 'ro'], 
            application)
        self._rexprPageLink = None

    def getNameOfStaticFile(self, name, language = None):
        '''Calculates the name of a static content file.
        @param name: the part of the filename without language and extension
        @return: the full path of the file 
        '''
        if language == None:
            language = self._language
        fn = (self._homeDir + 'data/' + language + '/' + name + '-' 
            + language + '.htm')
        if not os.path.exists(fn) and language != 'en':
            fn = (self._homeDir + 'data/en/' + name + '-en.htm')
        return fn
    
    def translateInternalRefs(self, line):
        '''Change all internal links in a given line.
        @param line: the line to change
        @return: the line with the corrected links
        '''
        if self._rexprPageLink == None:
            self._rexprPageLink = re.compile(
                r'href="([\w.-]*?)-([a-z]{2}(-[a-z]{2})?)[.]htm')
        line = self._rexprPageLink.sub(r'href="\1', line)
        line = line.replace('href="../lib', 'href="/static/lib')
        line = line.replace('src="../lib', 'src="/static/lib')
        return line
    
    def getBodyOfStatic(self, filename):
        '''Extracts the body of a full html document.
        @param filename: the filename of the document with path
        @return: the body of the document
        '''
        rc = ''
        if not os.path.exists(filename):
            self.error('getBodyOfStatic(): not found: ' + filename)
        else:
            self.log('getBodyOfStatic(): reading ' + filename)
            key = 'content.start'
            marker = self.getConfig(key)
            if marker == key:
                marker = 'id="main-page'
            ignore = True
            with codecs.open(filename, "r", "UTF-8") as fp:
                for line in fp:
                    if ignore and line.find(marker) >= 0:
                        ignore = False
                    elif not ignore:
                        if line.find('</body>') >= 0:
                            break
                        if line.find('href="') >= 0 or line.find('src="'):
                            line = self.translateInternalRefs(line)
                        rc += line
            fp.close()
            key = 'content.end.ignoreddivs'
            value = self.getConfig(key)
            countDivs = 1 if value == key else int(value)
            while countDivs > 0:
                countDivs -= 1
                ix = rc.rfind('</div>')
                if ix >= 0:
                    rc = rc[0:ix]
        return rc
    
    def getTemplate(self, node):
        '''Gets a template file into a string.
        @param: node: the file's name without path
        @return: the content of the template file
        '''
        fn = self._homeDir + 'templates/' + node
        rc = Util.readFileAsString(fn)
        return rc
    
    def buildStaticPage(self, page, menuBody):
        '''Builds a page from a given HTML body.
        @param page: the name of the page: defines the 
        @param menuBody: the HTML code of the menu
        @return: the HTML code of the page 
        '''
        fn = self.getNameOfStaticFile(page)
        content = self.getBodyOfStatic(fn)
        params = {'content': content, 
            'LANGUAGE' : 'de', 
            'txt_title' : 'sidu-help',
            'META_DYNAMIC' : '',
            'STATIC_URL' : '',
            'MENU' : menuBody,
            'CONTENT' : content,
            '!title' : self.getConfig('.static.title')
            }
        rc = self.getTemplate('pageframe.html')
        rc = self.replaceVars(rc, params)
        return rc
        