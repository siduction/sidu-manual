'''
Created on 14.03.2013

@author: hm
'''
import unittest

from source.globalpage import GlobalPage
from pyunit.aux import Aux

class TestGlobalPage(unittest.TestCase):


    def setUp(self):
        pass


    def tearDown(self):
        pass


    def testBasic(self):
        session = Aux.getSession()
        globalPage = GlobalPage(session, {})
        self.assertTrue(None != globalPage)


#if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    #unittest.main()
