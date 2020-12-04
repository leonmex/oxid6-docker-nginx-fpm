#!/usr/bin/env bash
set -e

# bootstrap oxid files/project
if [ ! -f /var/www/html/source/config.inc.php ]
then
	echo "#####################################"
	echo "####### COMPOSER START ##############"
	cd /var/www/
	composer create-project --keep-vcs oxid-esales/oxideshop-project ./html ${OXID_VERSION} -vvv
	cp /var/www/config.inc.php /var/www/html/source/config.inc.php
	chown -R www-data:www-data /var/www/html/source/
	echo "#####################################"
	echo "##### OXID bootstrap completed! #####"
	echo "#####################################"
fi
