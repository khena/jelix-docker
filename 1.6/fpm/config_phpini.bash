#!/bin/bash

# don't change the indentation !
# easy way, maybe some php.ini template with sed later
if [ ! -f ${PHP_INI_DIR}/php.ini ]
then
touch ${PHP_INI_DIR}/php.ini
echo -e \
"magic_quotes_gpc = Off\n"\
"magic_quotes_runtime = Off\n"\
"session.auto_start = 0\n"\
"safe_mode = Off\n"\
"register_globals = Off\n"\
"asp_tags = Off\n"\
"short_open_tag = Off\n"\
"sendmail_path = /usr/sbin/sendmail -t\n"\
"upload_max_filesize = ${UPLOAD_MAX-8}M\n"\
"post_max_size = ${UPLOAD_MAX-8}M\n"\
"date.timezone = ${TZ-Europe/Paris}\n"\
"max_execution_time = ${TIME_MAX-600}\n"\
"memory_limit = ${MEMORY_MAX-256}M"\
>> ${PHP_INI_DIR}/php.ini
fi
