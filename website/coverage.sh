#! /bin/bash
DIR_COVER=/tmp/cover-sidu-manual
BROWSER=/usr/bin/opera

if [ ! -f /usr/bin/nosetests ] ; then
	echo "missing packet python-nose"
	exit 1
fi
if [ ! -d /usr/share/pyshared/coverage ] ; then
	echo "missing packet python-coverage"
	exit 1
fi
rm -Rf $DIR_COVER
nosetests --with-coverage --cover-html --cover-html-dir=$DIR_COVER tests.py
if [ -x $BROWSER ] ; then
	$BROWSER $DIR_COVER/index.html
fi

