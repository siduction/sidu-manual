'''
Created on 07.09.2013

@author: hm
'''

import logging, os.path, importlib
from djinn.django.http import HttpResponse, HttpResponsePermanentRedirect
logger = logging.getLogger("sidu-manual")

def dumpObj(obj):
    '''Returns a string describing an object instance
    @param obj:    object to describe
    @return:     a string describing the object
    '''
    return repr(obj)
                
 
def decodeUrl(url):
    '''Decodes the special characters in an URL into normal string.
    Special chars are %hh where hh is a 2 digit hexadecimal number.
    @param url:     the url to decode
    @return:        the decoded string
    '''
    rc = ""
    url = url.replace("+", " ")
    ix = last = 0
    while ix >= 0 and last < len(url):
        ix = url.find("%", last)
        if ix < 0:
            rc += url[last:]
        else:
            rc += url[last:ix]
            hexNumber = url[ix+1:ix+3]
            cc = int(hexNumber, 16)
            rc += chr(cc)
            last = ix + 3
    return rc


class WSGIHandler(object):
    '''
    Implements the a simple replacement of Django which implements the 
    Web Server Gateway Interface (WSGI)
    '''


    def __init__(self, urlPatterns = None):
        '''Constructor.
        '''
        if urlPatterns == None:
            moduleName = os.environ["URL_MODULE"]
            module = importlib.import_module(moduleName)
            urlPatterns = module.getPatterns()
        if urlPatterns[0] == '':
            urlPatterns = urlPatterns[1:]
        self._urlPatterns = urlPatterns
        self._blockSize = 0x10000
        self._environ = None
        self._request = None
        
    def dumpUrl(self, urls):
        '''Dumps the url list.
        @return: a string describing the urls
        '''
        rc = ""
        for item in urls:
            rc += "{:s}: {:s}\n".format(item._regExpr.pattern, item._name)
        return rc
    
    def findUrl(self, url):
        '''Returns the first matching UrlInfo object.
        @param url    the url to search
        @return:     None: not found
                     otherwise: an UrlInfo instance
        '''
        rc = None
        if url.startswith("/"):
            url = url[1:]
        for item in self._urlPatterns:
            if item._regExpr.search(url):
                rc = item
                break
        if rc == None:
            raise Exception("URL not found: " + url + " urls" + self.dumpUrl(self._urlPatterns))
        return rc
           
    def putCookies(self, cookies):
        '''Write the cookies to the client.
        @param cookies:    a dictionary with the cookies
        '''
        pass
    
    def writeContent(self, content):
        '''Writes the content of the current page to the client.
        @param content:     the page content (normally HTML)
        '''
        pass

    def findMime(self, filename):
        '''Finds the MIME type of a filename.
        @param fn:  filename (from the url)
        @return:    the mime type
        '''
        node = os.path.basename(filename)
        ix = node.rindex(".")
        ext = "" if ix < 0 else node[ix+1:].lower()
        if ext == "css":
            rc = "text/css"
        elif ext == "png":
            rc = "image/png"
        elif ext == "jpg":
            rc = "image/jpg"
        elif ext == "gif":
            rc = "image/gif"
        elif ext == "ico":
            rc = "image/x-icon"
        elif ext == "txt" or ext == "log":
            rc = "text/plain"
        elif ext == "htm" or ext == "html":
            rc = "text/html"
        else:
            rc = "application/octet-stream"
        return rc
    
    def handleStaticFiles(self, url, documentRoot, startResponse):
        '''Handles a static file.
        @param url:            the url of the static file, e.g. "/static/std.css"
        @param documentRoot:   the base path of the application
        @param startResponse:  a method which writes the HTTP header
        @return: a list with the file's content (in 64 kiByte blocks)
        '''
        fn = documentRoot + url
        if not os.path.exists(fn):
            # CONTENT_LENGTH will be added by the caller! 
            headers = [("Content-Type","text/plain")]
            answer = "file not found: " + url + "\n"
            startResponse.__call__(404, headers)
            rc = [answer]
        else:
            mime = self.findMime(url)
            rc = []
            fp = open(fn, "r")
            while True:
                # performance: put 64k blocks into the output
                part = fp.read(self._blockSize)
                if len(part) == 0:
                    break
                else:
                    rc.append(part)
            fp.close()
            headers = [("Content-Type", mime)]
            startResponse.__call__(200, headers)
        return rc
    
    def handle(self, application, documentRoot, startResponse):
        '''Handles a HTTP request.
        @param application:    the name of the application (is the virtual host)
        @param documentRoot:   the base path of the application
        @param startResponse:  a method which writes the HTTP header
        '''
        rc = None
        if not "PATH_INFO" in self._environ:
            logger.error("missing PATH_INFO")
            raise Exception("djinn.handle(): no PATH_INFO found")
        else:
            url = self._environ["PATH_INFO"]
            if url == "/favicon.ico":
                url = "/static/favicon.icon"
            headers = []
            info = self.findUrl(url)
            if info == None:
                logger.error("Page not found: " + url)
                raise Exception("djinn.handle(): no Page found: " + url)
            else:
                handler = info._urlHandler
                self._request.documentRoot = documentRoot
                rc = handler.__call__(self._request)
                # rc is a HttpResponse or a HttpResponsePermanentRedirect
                if isinstance(rc, HttpResponse):
                    # CONTENT_LENGTH will be added by the caller! 
                    self.content = rc.content
                    header = ("Content-Type", "text/html")
                    headers.append(header)
                elif isinstance(rc, HttpResponsePermanentRedirect):
                    header = ("Location", rc.absUrl)
                    headers.append(header)
                startResponse.__call__(rc.status, headers)
        return rc
            
    def __call__(self, environ, startResponse):
        '''the main method of the WSGI.
        @param environ:        the parameters as a dictionary
        @param startResponse:  a callable starting the HTTP response.
                               def startResponse(status, headers)
                               e.g. startResponse("200 OK", [("LEN", "20")]
        '''
        
        application = environ["HTTP_HOST"]
        docRoot = environ["DOCUMENT_ROOT"] if "DOCUMENT_ROOT" in environ else "/usr/share/sidu-manual"
        self._environ = environ
        self._request = WSGIRequest(environ)
        
        rc = self.handle(application, docRoot, startResponse)
        return rc
        
class WSGIRequest:
    '''Implements the request instance expected from WSGI applications.
    '''
    def __init__(self, environ):
        self._cookies = {}
        self.META = environ
        self.GET = {}
        self.POST = {}
        self.COOKIES = {}
        self.buildGET(environ)
        self.buildCookies(environ)

    def buildGET(self, environ):
        '''Builds the GET dictionary from an URL.
        @param environ:    the data from the client
        '''
        self.GET = {}
        if "QUERY_STRING" in environ:
            queryString = environ["QUERY_STRING"]
            items = queryString.split("&")
            for varDef in items:
                if varDef == "":
                    continue
                if varDef.find("=") > 0:
                    (name, value) = varDef.split("=", 1)
                else:
                    (name, value) = (varDef, "")
                name = decodeUrl(name)
                value = decodeUrl(value)
                self.GET[name] = value
            
    def buildCookies(self, environ):
        '''Fills the dictionary COOKIES.
        @param httpCookies: the http-url of the cookies
        '''
        self.COOKIES = {}
        if "HTTP_COOKIE" in environ:
            queryString = environ["HTTP_COOKIE"]
        
            
