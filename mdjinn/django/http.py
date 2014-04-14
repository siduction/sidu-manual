'''
Defines the response classes neccessary for Django compatibility.

@author: hm
'''

# marker for distinction from the original Django module
djinnMarker = True

class HttpBaseResponse():
    '''Base class for all responses.
    '''
    def __init__(self, status):
        '''Constructor.
        @param status:     the status returned, e.g. "200 OK"
        '''
        self.status = status
        self.cookies = {}
        
    def set_cookie(self, name, value):
        '''Stores a cookie which is written to the client later.
        @param name:     coolie's name
        @param value:    cookie's value
        '''
        self.cookies[name] = value        
       
    
class HttpResponse(HttpBaseResponse):
    '''
    The response if the page has text content.
    '''


    def __init__(self, body):
        '''Stores the HTML body of the current page.
        @param content:    the HTML text of the page
        '''
        HttpBaseResponse.__init__(self, "200 OK")
        self.content = body

class HttpResponsePermanentRedirect(HttpBaseResponse):
    '''Implements a response for a permanent redirect.
    '''
    
    def __init__(self, absUrl):
        '''Stores the absolute URL.
        @param absUrl:    the full URL
        '''
        HttpBaseResponse.__init__(self, "301 Moved Permanently")
        self.absUrl = absUrl
