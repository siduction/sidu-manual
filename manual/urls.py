from djinn.django.conf.urls import patterns, url

from website import views

def getPatterns():
    rc = patterns('',
        url(r'^/?$', views.home, name='home'),
        url(r'^/?!search', views.search, name='search'),
        url(r'^/?static', views.search, name='staticFiles'),
        url(r'^/?[_!]language.*', views.language, name='language'),
        url(r'^/?!check', views.check, name='check'),
        url(r'^/?!expert', views.expert, name='expert'),
        url(r'^/?(?P<page>[\w+.+-]+)$', views.staticPage, name='static'),
    )
    return rc

urlpatterns = getPatterns()