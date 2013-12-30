#! /bin/bash
./import_config.sh
sudo chown -R hm /usr/share/sidu-manual /usr/share/sidu-base
rsync -vua data /usr/share/sidu-manual/data
cp -v templates/* /usr/share/sidu-manual/templates
cp -v msource/* /usr/share/sidu-manual/msource
cp -v config/* /usr/share/sidu-manual/config
#cp -v website/static/lib/flags/* /usr/share/sidu-manual/website/static/flags
cd ../../sidu-base
rsync -va util/ webbasic/ /usr/share/sidu-base

