"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""

import os.path
from django.test import TestCase
from website.session import Session
from util.util import Util 
from util.configurationbuilder import ConfigurationBuilder, SqLiteConfigurationDb

class DummyRequest:
    def __init__(self):
        self.META = {}
        self.META['HTTP_ACCEPT_LANGUAGE'] = 'de'
        
class SimpleTest(TestCase):
    def setUp(self):
        fn = Util.getTempFile('config.db', 'sidu-help')
        if not os.path.exists(fn):
            self._db = SqLiteConfigurationDb(fn)
            self._db.buildConfig()
            config = ConfigurationBuilder(self._db)
            dirBase = '..' + os.sep + '..' + os.sep + 'sidu_base' + os.sep + 'config'
            config.addDirectory(dirBase, 'sidu-base', '.conf')
            dirHelp =  '..' + os.sep + '..' + os.sep + 'sidu_help' + os.sep + 'config'
            config.addDirectory(dirHelp, 'sidu-help', '.conf')
            
            
    def getRequest(self):
        return DummyRequest()
    
    def getSession(self):
        return Session(self.getRequest(), 'sidu-help')
        
    def test0Start(self):
        self.setUp()
           
    def testSessionGetNameOfStaticFile(self):
        session = self.getSession()
        self.assertEquals('/home/ws/py/sidu_help/website/static/de/home-de.htm',
            session.getNameOfStaticFile('home', 'de'))
        self.assertEquals('/home/ws/py/sidu_help/website/static/en/home-en.htm',
            session.getNameOfStaticFile('home', 'en'))
        
    
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
