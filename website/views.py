# Create your views here.
from django.http import HttpResponse, HttpResponsePermanentRedirect
from source.session import Session
from webbasic.menu import Menu
from webbasic.htmlsnippets import HTMLSnippets
from webbasic.pagedata import PageData
from source.searchpage import SearchPage
from source.languagepage import LanguagePage
from source.globalpage import GlobalPage
from source.checkpage import CheckPage
from source.expertpage import ExpertPage

def getSession(request):
    session = Session(request, 'sidu-manual')
    session._globalPage = GlobalPage(session, request.COOKIES)
    return session

def getMenu(session):
    menu = Menu(session, 'menu', True)
    menu.read()
    snippets = HTMLSnippets(session)
    snippets.read('menu')
    menuHtml = menu.buildHtml(snippets)
    return menuHtml

def writeCookies(response):
    cookies =  PageData._cookie
    for cookie in cookies:
        response.set_cookie(cookie, cookies[cookie])
    
def handlePage(page, request, session):
    page._globalPage = session._globalPage
    
    htmlMenu = getMenu(session)
    fields = request.GET
    if len(fields) < len(request.POST):
        fields = request.POST
    
    pageResult = page.handle(htmlMenu, fields, request.COOKIES)
    if pageResult._body != None:
        rc = HttpResponse(pageResult._body)
    else:
        url = pageResult._url
        session.trace('redirect to {:s} [{:s}]'.format(url, pageResult._caller))
        absUrl = session.buildAbsUrl(url)
        rc = HttpResponsePermanentRedirect(absUrl)
    writeCookies(rc); 
    return rc
    
def index(request):
    session = getSession(request)
    homePage = session.getConfigOrNoneWithoutLanguage('.home.page')
    if homePage == None:
        homePage = 'welcome'
    absUrl = session.buildAbsUrl(homePage)
    rc = HttpResponsePermanentRedirect(absUrl) 
    return rc

def expert(request):
    session = getSession(request)
    rc = handlePage(ExpertPage(session), request, session)
    return rc

def search(request):
    session = getSession(request)
    rc = handlePage(SearchPage(session), request, session)
    return rc

def check(request):
    session = getSession(request)
    rc = handlePage(CheckPage(session), request, session)
    return rc

def language(request):
    session = getSession(request)
    rc = handlePage(LanguagePage(session), request, session)
    return rc

def staticPage(request, page):
    session = getSession(request)
    menuHtml = getMenu(session)
    body = session.buildStaticPage(page, menuHtml)
    rc = HttpResponse(body)
    return rc

def home(request):
    session = getSession(request)
    homePage = session.getConfigOrNoneWithoutLanguage('.home.page')
    if homePage == None:
        homePage = 'welcome'
    absUrl = session.buildAbsUrl(homePage)
    rc = HttpResponsePermanentRedirect(absUrl) 
    return rc
