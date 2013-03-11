'''
Created on 10.03.2013

@author: hm
'''

from webbasic.page import Page
from session import Session

class SearchPage(Page):
    '''
    Handles the search page
    '''


    def __init__(self, session):
        '''
        Constructor.
        '''
        Page.__init__(self, 'search', session)
        self._searchResults = None

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
        isEmpty = True
        snippet = 'EMPTY_RESULT' if isEmpty else 'RESULT_LIST'
        code = self._snippets.get(snippet)
        if not isEmpty:
            code = code.replace('{{search.results}}', self._searchResults)
        
        body = body.replace('{{RESULT}}', code)
            
        if self._searchResults != None:
            body = body.replace('{{search.results}}', self._searchResults)
        return body
    
    def doSearch(self, phrases):
        '''Runs a search and stores the result in _searchResults
        @param phrases: the search phrases
        '''
        self._searchResults = 'Nothing searched, nothing found'
        
        
    def handleButton(self, button):
        '''Do the actions after a button has been pushed.
        @param button: the name of the pushed button
        @return: None: OK<br>
                otherwise: a redirect info (PageResult)
        '''
        pageResult = None
        if button == 'button_search':
            self._searchResults = self.doSearch(self._data.get('phrases'))
        else:
            self.buttonError(button)
            
        return pageResult
    