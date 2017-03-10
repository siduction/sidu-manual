'''
Implements the interface for URL patterns given by Django.

@author: hm
'''

import re

# marker for distinction from the original Django module
djinnMarker = True

def url(regexpr, caller, name):
    '''Returns an instance storing the arguments.
    @param regexpr: the pattern describing the URL
    @param caller: the handle for the URL
    @param name: the name of the caller
    '''
    return UrlInfo(regexpr, caller, name)

def patterns(prefix, *args):
    '''Returns the list of the URL patterns given by the arguments.
    @param dummy:    not used
    @param *args:    a list of UrlInfo instances
    @return:         the list of UrlInfo instances
    '''
    rc =[]
    for item in args:
        rc.append(item)
    return rc

class UrlInfo(object):
    '''
    Stores the info of an URL pattern.
    @param pattern:    a regular expression describing the URL
    @param handler:    the handler of the URL
    @param name:       a name of the URL
    '''
    def __init__(self, pattern, handler, name):
        '''
        Constructor
        '''
        self._urlHandler = handler
        dummy = self._urlHandler
        self._name = name
        self._regExpr = re.compile(pattern)
        