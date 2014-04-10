"""
WSGI config for sidu-help project.

This module contains the WSGI application used by Django's development server
and any production WSGI deployments. It should expose a module-level variable
named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
this application via the ``WSGI_APPLICATION`` setting.

Usually you will have the standard Django WSGI application here, but it also
might make sense to replace the whole Django WSGI application with a custom one
that later delegates to the Django one. For example, you could introduce WSGI
middleware here, or combine a Django application with an application of another
framework.

"""
import os.path, sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "sidu-manual.settings")

cdir = os.getcwd()
if not cdir in sys.path:
	sys.path.insert(0, cdir)
	
# This application object is used by any WSGI server configured to use this
# file. This includes Django's development server, if the WSGI_APPLICATION
# setting points here.
if os.path.exists('/usr/share/pyshared/django/core/handlers/wsgi.py'):
	from django.core.handlers.wsgi import WSGIHandler
	appl = WSGIHandler()
else:
    	from django.core.wsgi import get_wsgi_application
	appl = get_wsgi_application()
application = appl
