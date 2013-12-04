'''
Created on 09.03.2013

@author: hm
'''
import os.path

from unittest import TestCase, main

from util.configurationbuilder import SqLiteConfigurationDb, ConfigurationBuilder
from source.session import Session
from util.util import Util

class DummyRequest:
    def __init__(self):
        self.META = {
            'HTTP_ACCEPT_LANGUAGE' : 'de',
            'SERVER_NAME' : 'sidu-manual',
            'SERVER_PORT' : '8086',
        }
        
class SessionTest(TestCase):

    def setUp(self):
        fn = Util.getTempFile('config.db', 'sidu-help')
        if not os.path.exists(fn):
            self._db = SqLiteConfigurationDb(fn)
            self._db.buildConfig()
            config = ConfigurationBuilder(self._db)
            dirBase = '../../sidu-base/config'
            config.addDirectory(dirBase, 'sidu-base', '.conf')
            dirHelp =  '../config'
            config.addDirectory(dirHelp, 'sidu-help', '.conf')
            
            
    def getRequest(self):
        return DummyRequest()
    
    def getSession(self):
        return Session(self.getRequest(), 'sidu-help')
      
    def testGetBodyOfStatic2(self):
        session = self.getSession()
        session.getBodyOfStatic('notExistingTestFile.xxx')
        
    def testSessionGetNameOfStaticFile(self):
        session = self.getSession()
        home = session._homeDir
        self.assertEquals(home + 'website/static/de/home-de.htm',
            session.getNameOfStaticFile('home', 'de'))
        self.assertEquals(home + 'website/static/en/home-en.htm',
            session.getNameOfStaticFile('home', 'en'))
        self.assertEquals(home + 'website/static/en/home-en.htm',
            session.getNameOfStaticFile('home', 'ru'))
        
    
    def testSessiontranslateInternalRefs(self):
        session = self.getSession()
        self.assertEquals('<a href="home">',
            session.translateInternalRefs('<a href="home-de.htm">'))
        self.assertEquals('<img src="/static/images-de/installer-de/installer1-de.png">',
            session.translateInternalRefs('<img src="../images-de/installer-de/installer1-de.png">'))

    def testGetBodyOfStatic(self):
        session = self.getSession()
        fn = Util.getTempFile('test_html.htm', 'sidu-help')
        Util.writeFile(fn, '''
<html>
<body>
<div id="main-page">
<p>Text</p>
</div>
</body>
</html>
'''         )
        self.assertEquals("<p>Text</p>\n", session.getBodyOfStatic(fn))

    def testGetTemplate(self):
        session = self.getSession()
        content = session.getTemplate('pageframe.html')
        self.assertTrue(content.find('body') > 0)
        
    def testBuildStaticPage(self):
        session = self.getSession()
        rc = session.buildStaticPage('home', 'MyMenu')
        self.assertTrue(rc.find('MyMenu') > 0)
        
if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    main()
