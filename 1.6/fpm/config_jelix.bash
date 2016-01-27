#!/bin/bash
echo "Searching for an existing install in $(pwd)..."
if [ -d ${APP_NAME} -a -f ${APP_NAME}/application.init.php ]
then
        echo "Application ${APP_NAME} found ! Let's go!"
        cd ${APP_NAME}
else
        echo "No installation in /var/www/${APP_NAME}, installing now..."
	tar cf - --one-file-system -C ${SOURCE_DIR}/jelixfwk . | tar xf -
        cd lib/jelix-scripts && php createapp.php /var/www/${APP_NAME} && cd -
        # php must be independent for web server configuration, we use the "old" fashion for lib/jelix-www      
        ln -s ../../lib/jelix-www /var/www/${APP_NAME}/www/jelix
        chown www-data:www-data temp/${APP_NAME}*  ${APP_NAME}/var/log
        chmod g+w temp/${APP_NAME}* ${APP_NAME}/var/log
	# configure db if ENV MYSQL is set
fi
