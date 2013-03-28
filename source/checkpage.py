'''
Created on 13.03.2013

@author: hm
'''
import operator

from webbasic.page import Page
from webbasic.configcheck import ConfigChecker
from webbasic.menucheck import MenuChecker
from webbasic.filecheck import FileChecker

class CheckPage(Page):
    '''
    Allows the selection of the language.
    '''
    def __init__(self, session):

        '''
        Constructor.
        @param session: the session info
        '''
        Page.__init__(self, 'check', session)
        self._resultBody = None
        self._resultTitle = None

    def defineFields(self):
        '''Defines the fields of the page.
        This allows a generic handling of the fields.
        '''
        self.addField('language')

        
    def checkConfig(self):
        checker = ConfigChecker(self._session)
        self._resultTitle = self._session.getConfig('check.config.title')
        self._resultBody = checker.checkConfig(self.getField('language'),
            self._snippets.get('KEY_DIFF'), self._snippets.get('KEY_SEPARATOR'))
     
    def checkMenu(self):
        checker = MenuChecker(self._session, self._session._homeDir)
        self._resultTitle = self._session.getConfig('check.menu.title')
        self._resultBody = checker.checkMenu(self.getField('language'),
            self._snippets.get('KEY_DIFF'))
        
    def buildTableMenu(self):
        self._resultTitle = self._session.getConfig('check.menu.table.title')
        checker = MenuChecker(self._session, self._session._homeDir)
        self._resultBody = checker.buildTable(self.getField('language'))
             
    def checkFiles(self):
        '''Tests the completeness of the files.
        '''
        lang = self.getField('language')
        if lang == None:
            lang = 'de'
        dirLang = self._session._homeDir + 'data/' + lang
        dirEn = self._session._homeDir + 'data/en'
        
        self._resultTitle = self._session.getConfig('check.file.title')
        checker = LangFileChecker(self._session)
        checker.setLang(lang, 'en')
        (missingLang, missingEn) = checker.compareDirs(dirLang, dirEn, '.*[.]htm$')
        message = None
        html = self._snippets.get('PART_RESULT')
        separator = self._snippets.get('KEY_SEPARATOR')
        if missingLang != None:
            message = (self._session.getConfig('check.files.native.missing')
                   .format(lang) + separator.join(missingLang))
            message = html.replace('{{message}}', message)
            
        if missingEn != None:
            msg = (self._session.getConfig('check.files.english.missing')
                   + separator.join(missingEn))
            msg = html.replace('{{message}}', msg)
            if message == None:
                message = msg
            else:
                message += msg
        self._resultBody = message
            
        message = self._snippets.get('KEY_DIFF').replace('{{message}}', message)
            
    def changeContent(self, body):
        '''Changes the template in a customized way.
        @param body: the HTML code of the page
        @return: the modified body
        '''
        field = 'language'
        curLanguage = self.getField(field)
        values = []
        for lang in self._session._supportedLanguages:
            if lang != 'en':
                values.append(lang)
        if curLanguage == None:
            ix = 0
        else:
            ix = operator.indexOf(values, curLanguage)
        body = self.fillOpts(field, values, None, ix, body)
        if self._resultTitle == None:
            title = ''
            result = ''
        else:
            title = self._snippets.get('RESULT_TITLE')
            title = title.replace('{{title}}', self._resultTitle)
            if self._resultBody == None:
                result = self._snippets.get('EMPTY_BODY')
            else:
                result = self._resultBody
        body = body.replace('{{RESULT_TITLE}}', title)
        body = body.replace('{{RESULT}}', result)
        return body
    
    def handleButton(self, button):
        '''Do the actions after a button has been pushed.
        @param button: the name of the pushed button
        @return: None: OK<br>
                otherwise: a redirect info (PageResult)
        '''
        pageResult = None
        if button == 'button_check_config':
            self.checkConfig()
        elif button == 'button_check_menu':
            self.checkMenu()
        elif button == 'button_table_menu':
            self.buildTableMenu()
        elif button == 'button_files':
            self.checkFiles()
        else:
            self.buttonError(button)
            
        return pageResult
  
class LangFileChecker(FileChecker):
    def __init__(self, session):
        FileChecker.__init__(self, session)
        self._lang1 = None
        self._lang2 = None
    def setLang(self, lang1, lang2):
        self._lang1 = lang1 + '.'
        self._lang2 = lang2 + '.'

    def normFilename(self, name, dir1NotDir2):
        if dir1NotDir2:
            name = name.replace(self._lang1, '')
        else:
            name = name.replace(self._lang2, '')
        return name
          