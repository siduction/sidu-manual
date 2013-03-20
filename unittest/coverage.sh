#! /bin/bash
DIR_COVER=/tmp/cover-sidu-manual
BROWSER=/usr/bin/opera
BASE1=/home/ws/py
BASE2=/usr/share
export PYTHONPATH="$BASE1/sidu-manual:$BASE1/sidu-base:$BASE1/pyygle:$BASE2/sidu-manual:$BASE2/sidu-base:$BASE2/pyygle:$PYTHONPATH"
if [ ! -f /usr/bin/nosetests ] ; then
	echo "missing packet python-nose"
	exit 1
fi
if [ ! -d /usr/share/pyshared/coverage ] ; then
	echo "missing packet python-coverage"
	exit 1
fi
rm -Rf $DIR_COVER
nosetests --with-coverage --cover-html --cover-html-dir=$DIR_COVER *test.py
if [ -x $BROWSER ] ; then
	$BROWSER $DIR_COVER/index.html
fi

