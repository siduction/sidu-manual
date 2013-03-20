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
        self._search.defineFields()


    def tearDown(self):
        pass


    def testBasic(self):
        search = self._search
        search.defineFields()
        self.assertTrue(None == search._pageData.get('phrases'))
        

    def testDefineFields(self):
        search = self._search
        search.defineFields()
        self.assertTrue(None == search._pageData.get('phrases'))

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
    
    def testSplitPhrases(self):
        ph = self._search.splitPhrases('"a" x "b" y z "c')
        self.assertEqual('"a"', ph[0]) 
        self.assertEqual('x', ph[1]) 
        self.assertEqual('"b"', ph[2]) 
        self.assertEqual('y', ph[3]) 
        self.assertEqual('z', ph[4]) 
        self.assertEqual('"c"', ph[5]) 

        ph = self._search.splitPhrases('"a" "b" "c')
        self.assertEqual('"a"', ph[0]) 
        self.assertEqual('"b"', ph[1]) 
        self.assertEqual('"c"', ph[2]) 

        ph = self._search.splitPhrases('abc def')
        self.assertEqual('abc', ph[0]) 
        self.assertEqual('def', ph[1]) 

        ph = self._search.splitPhrases(' abc def ')
        self.assertEqual('abc', ph[0]) 
        self.assertEqual('def', ph[1]) 

        ph = self._search.splitPhrases('abc def +a      33\tblub')
        self.assertEqual('abc', ph[0]) 
        self.assertEqual('def', ph[1]) 
        self.assertEqual('+a', ph[2]) 
        self.assertEqual('33', ph[3]) 
        self.assertEqual('blub', ph[4]) 
if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()