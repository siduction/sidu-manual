#! /bin/bash

DIR_TRG=/tmp/menu
SRC=$1
export LANGUAGE=de
export LC_ALL=de
export LANG=de

function MkFn(){
	echo $2-$1.htm
}
function MkFull(){
	fn=$(MkFn $1 $2)
	echo ../website/static/$1/$fn 
}

if [ -z "$1" ] ; then
	echo "Usage extract_menu NAME"
	echo "Sample: extract_menu welcome"
	return 1
fi

test -d $DIR_TRG || mkdir $DIR_TRG
rm -f $DIR_TRG/*

FULL=$(MkFull en $SRC)
if [ ! -f $FULL ] ; then
	echo "not found: $FULL"
	return 2
fi


for lang in en de it pl ro pt-br ; do
	FN=$(MkFn $lang $SRC)
	FULL=$(MkFull $lang $SRC)
	perl html2menu.pl $FULL  >$DIR_TRG/menu_$lang.conf
done
echo "Result in $DIR_TRG"
