#! /bin/bash
set -x
for lang in de en it pl pt-br pt ro ; do
	DB=/tmp/sidu-manual_$lang.db
	echo $DB ...
	if [ ! -f $DB ] ; then
		python ../../pyygle/pyygle_src/pyygle.py --db=$DB parse fill-db ../website/static/$lang '[.]htm$' | tee -a /tmp/pyygle.sm.log
	fi
done
