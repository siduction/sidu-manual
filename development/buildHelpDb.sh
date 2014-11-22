#! /bin/bash
#set -x
TRG=~/manuals
test -d $TRG || mkdir $TRG
PYGGLE=/usr/share/pyygle/pyygle_src/pyygle.py
for lang in de en it pl pt-br ro ; do
	DB=$TRG/sidu-manual_$lang.db
	echo $DB ...
	if [ -f $DB ] ; then
		echo "+++ existiert schon $DB"
	else
		python $PYGGLE --db=$DB parse fill-db ../data/$lang '[.]htm$' | tee -a /tmp/pyygle.sm.log
	fi
done
