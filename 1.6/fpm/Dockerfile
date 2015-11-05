FROM php:fpm
MAINTAINER Guillaume "khena" Peres <rab_gui@yahoo.fr>

# for Dockerfile usage and easy maintenance
ENV JELIX_MAJOR_VERSION=1.6 JELIX_MINOR_VERSION=5 JELIX_EDITION=opt SOURCE_DIR=/usr/local/src/

# for docker run usage
ENV TZ=Europe/Paris APP_NAME=myapp UPLOAD_MAX=8 TIME_MAX=600 MEMORY_MAX=256

# docker goods practices
# supervisor to manage php and crontab
# cron for ... well for website usages)
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y \
    && apt-get install -y supervisor cron \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# php5-fpm extra configuration
RUN mkdir /php_conf
RUN echo "\ninclude = /php_conf/*.conf" >> /usr/local/etc/php-fpm.conf

# supervisor configuration cron + php5
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN curl -o jelixfwk.tar.gz http://download.jelix.org/jelix/releases/${JELIX_MAJOR_VERSION}.x/${JELIX_MAJOR_VERSION}.${JELIX_MINOR_VERSION}/jelix-${JELIX_MAJOR_VERSION}.${JELIX_MINOR_VERSION}-${JELIX_EDITION}.tar.gz \
	&& tar -xzf jelixfwk.tar.gz -C ${SOURCE_DIR} \
	&& rm jelixfwk.tar.gz \
	&& mv ${SOURCE_DIR}jelix-${JELIX_MAJOR_VERSION}.${JELIX_MINOR_VERSION}-${JELIX_EDITION} ${SOURCE_DIR}jelixfwk

COPY entrypoint.bash /entrypoint.bash
COPY config_jelix.bash /config_jelix.bash
COPY config_phpini.bash /config_phpini.bash
COPY config_timezone.bash /config_timezone.bash
RUN chmod +x /entrypoint.bash /config_jelix.bash /config_timezone.bash /config_phpini.bash

# /etc/apache2/sites-enabled
#Options +Multiviews
# apache 2 only AcceptPathInfo on

# ready to launch
WORKDIR /var/www

# conf.d is for cutom php.ini file
VOLUME ["/php_conf","/etc/cron.d","/usr/local/etc/php/conf.d"]

ENTRYPOINT ["/entrypoint.bash"]
CMD ["/usr/bin/supervisord","--configuration=/etc/supervisor/supervisord.conf"]
