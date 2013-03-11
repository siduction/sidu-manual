# Create your views here.
from django.http import HttpResponse
from source.session import Session
from webbasic.menu import Menu
from webbasic.htmlsnippets import HTMLSnippets
from source.searchpage import SearchPage

def getSession(request):
    session = Session(request, 'sidu-manual')
    return session

def getMenu(session):
    menu = Menu(session, 'menu', False)
    menu.read()
    snippets = HTMLSnippets(session)
    snippets.read('menu')
    menuHtml = menu.buildHtml(snippets)
    return menuHtml

def handlePage(page, request, session):
    htmlMenu = getMenu(session)
    fields = request.GET
    if len(fields) < len(request.POST):
        fields = request.POST
    pageResult = page.handle(htmlMenu, fields, request.COOKIES)
    if pageResult._body != None:
        rc = HttpResponse(pageResult._body)
    else:
        url = pageResult._url
        session.trace('redirect to {:s) [{:s}]'.format(url, pageResult._caller))
        absUrl = session.buildAbsUrl(url)
        rc = session.HttpResponsePermanentRedirect(absUrl) 
    return rc
    
def index(request):
    session = getSession(request)
    rc = session.redirect('/home', 'views.indes()')
    return rc

def search(request):
    session = getSession(request)
    rc = handlePage(SearchPage(session), request, session)
    return rc

def staticPage(request, page):
    session = getSession(request)
    menuHtml = getMenu(session)
    body = session.buildStaticPage(page, menuHtml)
    rc = HttpResponse(body)
    return rc

def home(request):
    session = getSession(request)
    rc = session.redirect('/home', 'views.home()')
    return rc
