'''
Created on 10.03.2013

@author: hm
'''
import re, os.path

from webbasic.page import Page
from pyygle_src.sqlite3db import SqLite3Db
from pyygle_src.searchengine import SearchEngine
from pyygle_src.pyygle import Logger

class SearchPage(Page):
    '''
    Handles the search page
    '''


    def __init__(self, session):
        '''
        Constructor.
        @param session: the session info
        '''
        Page.__init__(self, 'search', session)
        self._searchResults = None
        self._rexprDocument = re.compile(r'(.*?)[-_][a-z]{2}(-[a-z]{2})?\.htm$')

    def defineFields(self):
        '''Defines the fields of the page.
        This allows a generic handling of the fields.
        '''
        self.addField('phrases')

    def changeContent(self, body):
        '''Changes the template in a customized way.
        @param body: the HTML code of the page
        @return: the modified body
        '''
        isEmpty = False
        snippet = 'EMPTY_RESULT' if isEmpty else 'RESULT_LIST'
        code = self._snippets.get(snippet)
        if not isEmpty and self._searchResults != None:
            code = code.replace('{{search.results}}', self._searchResults)
        
        body = body.replace('{{RESULT}}', code)
            
        if self._searchResults != None:
            body = body.replace('{{search.results}}', self._searchResults)
        return body
    
    def buildUrl(self, docName, anchor):
        '''Builds an URL from a document name and (optionally) an anchor.
        @param docName: the filename containing the source
        @param anchor: the anchor of the hit
        @param: a link to the hit
        '''
        if anchor == None:
            anchor = ''
        elif anchor != '':
            anchor = '#' + anchor
        docName = os.path.basename(docName)
        matcher = self._rexprDocument.match(docName)
        if matcher == None:
            link = '/static/{:s}/{:s}.htm{:s}'.format(
                self._session._language, docName, self._session._language, anchor)
        else:
            link = matcher.group(1) + anchor
        return link

    def doSearch(self, phrases):
        '''Runs a search and stores the result in _searchResults
        @param phrases: the search phrases as a list
        '''
        if self._session._language =='':
            self._session._language = 'de'
        dbName =  '{:s}data/sidu-manual_{:s}.db'.format(
            self._session._homeDir, self._session._language)
        logger = Logger(None)
        db = SqLite3Db(dbName, logger)
        engine = SearchEngine(db)
        url = '!search'
        if len(phrases) <= 0:
            self._searchResults = 'Nothing searched, nothing found'
        else:
            self._searchResults = engine.search(phrases, url, False, self)
        db.close()
        
    def splitPhrases(self, source):
        '''Split a string into words and phrases.
        A phrase is a text delimited with "".
        @param: the text to split
        @return: a list of words and phrases
        '''
        rc = []
        end = 0
        rexpr = re.compile(r'\s+')
        while end >= 0:
            start = source.find('"', end)
            if start < 0:
                src = source[end:].strip()
                if src != '':
                    rc.extend(rexpr.split(src))
                break
            src = source[end:start].strip()
            if src != '':
                rc.extend(rexpr.split(src))
            end = source.find('"', start+1)
            if end < 0:
                rc.append(source[start:] + '"')
            else:
                end += 1
                rc.append(source[start:end])
        return rc   
    def handleButton(self, button):
        '''Do the actions after a button has been pushed.
        @param button: the name of the pushed button
        @return: None: OK<br>
                otherwise: a redirect info (PageResult)
        '''
        pageResult = None
        if button == 'button_search':
            phrases = self._pageData.get('phrases')
            if phrases != None:
                phrases = self.splitPhrases(phrases)
                self.doSearch(phrases)
        else:
            self.buttonError(button)
            
        return pageResult
    