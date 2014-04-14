#! /bin/bash
python ../sidu-base/util/configurationbuilder.py -v --summary --drop-tables --prefix=sidu-base data/config.db ../../sidu-base/master/config
python ../sidu-base/util/configurationbuilder.py -v --summary --prefix=sidu-manual data/config.db config

