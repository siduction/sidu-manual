# Create your views here.
from django.http import HttpResponse, HttpResponsePermanentRedirect
from website.session import Session
from webbasic.menu import Menu
from webbasic.htmlsnippets import HTMLSnippets


def getSession(request):
    session = Session(request, 'sidu-manual')
    return session

def index(request):
    session = getSession(request, 'sidu-manual')
    url = "http://" + session._host
    if session._port != None:
        url += ':' + session._port
    return HttpResponsePermanentRedirect(url)

def search(request):
    return HttpResponse("Sorry. This page is under construction")

def staticPage(request, page):
    session = getSession(request)
    menu = Menu(session, 'menu', False)
    menu.read()
    snippets = HTMLSnippets(session)
    snippets.read('menu')
    menuHtml = menu.buildHtml(snippets)
    fn = session.getNameOfStaticFile(page)
    content = session.getBodyOfStatic(fn)
    params = {'content': content, 
        'LANGUAGE' : 'de', 
        'txt_title' : 'sidu-help',
        'META_DYNAMIC' : '',
        'STATIC_URL' : '',
        'txt_top_menu_news' : 'See the news',
        'txt_top_menu_blog' : 'Our Blog',
        'txt_top_menu_wiki' : 'The Wiki',
        'txt_top_menu_forum' : 'The Forum',
        'txt_search_link' : ' Search',
        'MENU' : menuHtml,
        'CONTENT' : content,
        'txt_footer' : ''
        }
    rc = session.getTemplate('pageframe.html')
    rc = session.replaceVars(rc, params)
    rc = HttpResponse(rc)
    return rc

def home(request):
    session = getSession(request)
    rc = session.redirect('/home', 'view.home')
    return rc