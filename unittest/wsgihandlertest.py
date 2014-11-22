'''
Created on 08.04.2014

@author: hm
'''
import unittest, os.path

from mdjinn_not_active.wsgihandler import WSGIHandler
from util.util import Util

global_status = 0
global_headers = []
def dummyStartResponse(status, headers):
    global global_status, global_headers
    global_status = status
    global_headers = headers
    
class Test(unittest.TestCase):


    def setUp(self):
        self._app = WSGIHandler()
        self._app._blockSize = 5


    def tearDown(self):
        pass


    def testFindMime(self):
        self.assertEqual("text/plain", self._app.findMime("/static/x.log"))
        self.assertEqual("text/css", self._app.findMime("/x.y/x.CSS"))

    def testStaticFile(self):
        global global_headers
        fn = Util.getTempFile("test.png", "pyunit")
        Util.writeFile(fn, "SimpleTest")
        docRoot = os.path.dirname(os.path.dirname(fn))
        relPath = fn[len(docRoot):]
        rc = self._app.handleStaticFiles(relPath, docRoot, dummyStartResponse)
        self.assertEqual(("Content-Type", "image/png"), global_headers)
        self.assertEqual(200, global_status)
        self.assertEqual("Simpl", rc[0])
        self.assertEqual("eTest", rc[1])
        
    def testStaticFile404(self):
        global global_headers
        docRoot = "/not-existing!"
        relPath = "/unknown"
        rc = self._app.handleStaticFiles(relPath, docRoot, dummyStartResponse)
        self.assertEqual(("Content-Type", "text/plain"), global_headers)
        self.assertEqual(404, global_status)
        self.assertEqual(["file not found: /unknown\n"], rc)
        
if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testFindMime']
    unittest.main()