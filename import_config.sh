#! /bin/bash
python ../sidu-base/util/configurationbuilder.py -v --summary --drop-tables --prefix=sidu-base config.db ../sidu-base/config
python ../sidu-base/util/configurationbuilder.py -v --summary --prefix=sidu-manual config.db config

