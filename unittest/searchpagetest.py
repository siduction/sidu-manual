'''
Created on 11.03.2013

@author: hm
'''
import unittest, os

from pyunit.aux import Aux

from source.searchpage import SearchPage

class TestSearch(unittest.TestCase):


    def setUp(self):
        self._session = Aux.getSession()
        subdir = os.path.realpath(os.curdir)
        subdir = os.path.dirname(subdir)
        self._session._homeDir = subdir + "/"
        self._search = SearchPage(self._session)


    def tearDown(self):
        pass


    def testBasic(self):
        search = self._search
        search.defineFields()
        self.assertTrue(None == search._data.get('phrases'))
        

    def testDefineFields(self):
        search = self._search
        search.defineFields()
        self.assertTrue(None == search._data.get('phrases'))

    def testChangeContent(self):
        # body = body.replace('{{search.results}}', self._searchResults)
        search = self._search
        search._searchResults = 'Nothing'
        self.assertEquals('XNothingY', 
            search.changeContent('X{{search.results}}Y'))
    
    def testDoSearch(self):
        # self._searchResults = 'Nothing searched, nothing found'
        search = self._search
        search.doSearch('')
        self.assertTrue(None != search._searchResults)
        
        
    def testHandleButtons(self):
        '''Do the actions after a button has been pushed.
        @param button: the name of the pushed button
        @return: None: OK<br>
                otherwise: a redirect info (PageResult)
        '''
        search = self._search
        self.assertTrue(None == search.handleButton('button_search'))
        
        self.assertTrue(None == search.handleButton('button_unknown'))

if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()