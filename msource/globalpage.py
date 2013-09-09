'''
Created on 14.03.2013

@author: hm
'''

from webbasic.globalbasepage import GlobalBasePage

class GlobalPage(GlobalBasePage):
    '''
    Container for the global (= page independent) data
    '''


    def __init__(self, session, cookies):
        '''
        Constructor.
        @param session: the session info
        @fieldValues: the GET or POST dictionary of the request
        @cookies: the COOKIE dictionary from the request 
        '''
        GlobalBasePage.__init__(self, session, cookies)
        
    def defineFields(self):
        '''Defines the elements of the global data.
        '''
        #self.addField('language')
        pass
            