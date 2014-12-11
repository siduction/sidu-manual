'''
Created on 30.11.2014

@author: hm
'''
import unittest
from html2wiki import StackOfParseState, MediaWikiConverter, ParseState

class TestConverter(MediaWikiConverter):
    def __init__(self):
        super().__init__(None)
        self._lines = []
    def outFlush(self):
        for line in self._outLines:
            self._lines.append(line)
        if len(self._outBuffer) > 0:
            self._lines.append(self._outBuffer)
        self._outBuffer = ""

class Test(unittest.TestCase):

    def setUp(self):
        self._testAll = False

    def tearDown(self):
        pass
    
    def _createFile(self, name, content):
        fp = open(name, "w")
        fp.write(content)
        fp.close()

    def testStackOfParseState(self):
        if not self._testAll:
            return
        doc = MediaWikiConverter(None)
        stack = StackOfParseState(doc)
        s0 = stack.push("div")
        s0._listLevel = 0
        s1 = stack.push("span")
        s1._listLevel = 1
        s2 = stack.push("b")
        s2._listLevel = 2
        x1 = stack.pop('b', s2)
        self.assertTrue(s1 == x1)
        self.assertEqual(1, x1._listLevel)
        x0 = stack.pop('span', s1)
        self.assertTrue(s0 == x0)
        self.assertEqual(0, x0._listLevel)
        xx = stack.pop('div', s0)
        self.assertTrue(xx == None)
        
    def testStackOfParseState2(self):
        if not self._testAll:
            return
        doc = MediaWikiConverter(None)
        stack = StackOfParseState(doc)
        stack.push("div")
        self.assertEqual(1, len(stack._stack))
        stack.push("p")
        self.assertEqual(2, len(stack._stack))
        stack.push("b")
        self.assertEqual(3, len(stack._stack))
        self.assertEqual(0, stack.indexOfTag("div"))
        self.assertEqual(1, stack.indexOfTag("p"))
        self.assertEqual(2, stack.indexOfTag("b"))
        self.assertEqual(-1, stack.indexOfTag("bb"))
        
    def testDocumentBasics(self):
        if not self._testAll:
            return
        doc = MediaWikiConverter(None)
        state = ParseState("")
        self.assertEquals("<& >", doc.translateText("&lt;&amp;\n   &gt;", state))
                
    def testWrap(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc._wrapLength = 5
        state = ParseState("div")
        state._breakLines = True
        doc.out("1234. ((1*(2+(4))) and so on", state)
        self.assertEqual(doc._outLines[0], "1234.\n")
        self.assertEqual(doc._outLines[1], "((1*(\n")
        self.assertEqual(doc._outLines[2], "2+(4)))\n")
        self.assertEqual(doc._outLines[3], "and\n")
        self.assertEqual(doc._outLines[4], "so on\n")

    def testExtractContext(self):
        if not self._testAll:
            return
        fn = "/tmp/html2wiki_1.htm"
        self._createFile(fn, '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <html
xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
<head>
</head> 
<body class="body-main">
<div>
<div id="main-page"> 
<div class="text1" id="bois-prep">
</div>
                    <div id="rev">Page last revised 08/01/2012 1545 UTC</div>
</div>
</div>
</body>
</html>''')
        doc = MediaWikiConverter(fn)
        doc.readLines()
        self.assertEqual(15, len(doc._lines))
        doc.extractContent()
        self.assertEqual('<div class="text1" id="bois-prep">', doc._lines[0].strip())
        self.assertEqual(3, len(doc._lines))
        

    def testBlock(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse("<div><p>Hello World!</p><p>Lets go!</p></div>")
        self.assertEquals(["Hello World!\n\n", "Lets go!\n\n"], doc._lines)
        
    def testOl(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse("<ol><li>1\n<ol><li>A</li><li>B</li></ol>\n</li><li>2</li><li>\nX</li></ol>")
        self.assertEquals(["#1 \n", "##A\n", "##B\n", "#2\n", "# X\n"], doc._lines)

    def testUl(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse("<ul><li>1</li><li>2</li><li>\nX<ul><li>A</li><li>B</li></ul>\n</li></ul>")
        self.assertEquals(["*1\n", "*2\n", "* X\n", "**A\n", "**B\n"], doc._lines)

    def testPre(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse("<div>X\n<pre>1<2&2>4\n2\n</pre>\n<pre>A\nB</pre></div>")
        self.assertEquals(['X \n\n', '<pre>1<2&2>4\n2\n</pre>\n', '<pre>A\nB</pre>\n'],
                          doc._lines)
                           
    def testHx(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse("<div><h1>H1</h1><p>X</p><h2>H2</h2></div>")
        self.assertEquals(["= H1 =\n", "X\n\n", "== H2 ==\n"],
                          doc._lines)
    def testId(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse('<div id="first" class="highlighed"><h1 id="x1">H1</h1></div>')
        self.assertEquals(['<div id="first" class="highlighed"></div>' + "\n\n\n",
                '<div id="x1" />' + "\n= H1 =\n"],
                doc._lines)
    def testA(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse('<p>X<a href="http://bahn.de">Bahn</a>Y</p>')
        self.assertEquals(["X", "[http://bahn.de Bahn]Y\n\n"],
                doc._lines)
     
    def testImg(self):
        if False and not self._testAll:
            return
        doc = TestConverter()
        doc.parse('<div>X<div class="screenshot"><img src="any" title="start" alt="s"/></div>Y</div>')
        self.assertEquals(['X<div class="screenshot" />\n[[any|class=screenshot|alt=s|start]]\n\n', 'Y\n\n'],
                doc._lines)
     
    def testB(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse('<div><b>fat</b></div>')
        self.assertEquals(["'''fat'''\n\n"],
                doc._lines)
     
    def testI(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse('<div><i>italic</i></div>')
        self.assertEquals(["''italic''\n\n"],
                doc._lines)
     
    def testSpan(self):
        if not self._testAll:
            return
        doc = TestConverter()
        doc.parse('<div><span class="x">blabla</span></div>')
        self.assertEquals(['<span class="x">blabla</span>\n\n'],
                doc._lines)
           
if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testExtractContext']
    unittest.main()