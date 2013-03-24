'''
Created on 13.03.2013

@author: hm
'''
import operator

from webbasic.page import Page

class ExpertPage(Page):
    '''
    Handles the expert settings.
    '''
    def __init__(self, session):

        '''
        Constructor.
        @param session: the session info
        '''
        Page.__init__(self, 'expert', session)
 
    def defineFields(self):
        '''Defines the fields of the page.
        This allows a generic handling of the fields.
        '''
        self.addField('mode', 'F', 'b');

        
    def changeContent(self, body):
        '''Changes the template in a customized way.
        @param body: the HTML code of the page
        @return: the modified body
        '''
        body = self.fillCheckBox('mode', body)
        return body
    
    def handleButton(self, button):
        '''Do the actions after a button has been pushed.
        @param button: the name of the pushed button
        @return: None: OK<br>
                otherwise: a redirect info (PageResult)
        '''
        pageResult = None
        if button == 'button_set':
            value = 'T' if self.getField('mode') == 'T' else 'F'
            self._globalPage.putField('expert', value)
        else:
            self.buttonError(button)
            
        return pageResult
                