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
        self._nextItems = []
        
    def set_cookie(self, name, value):
        '''Stores a cookie which is written to the client later.
        @param name:     coolie's name
        @param value:    cookie's value
        '''
        self.cookies[name] = value        
       
    def __iter__(self):
        '''Implements the iterator feature for the class.
        @return: the iterator (the instance itself)
        '''
        self._nextItems = []
        if self.status == "200 OK":
            self._nextItems = [ self.content ]
        elif self.status == "301 Moved Permanently":
            self._nextItems = [ self.absUrl]
        return self
    
    def __next__(self):
        '''Implements the iterator feature for the class.
        @return: the next item of the "virtual list"
        '''
        if len(self._nextItems) == 0:
            raise StopIteration
        else:
            rc = self._nextItems[0]
            del self._nextItems[0]
            if type(rc) == unicode:
                rc = rc.encode('utf-8')
            return rc
    
    def next(self):
        '''Implements the iterator feature for the class.
        @return: the next item of the "virtual list"
        '''
        return self.__next__()
       
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
