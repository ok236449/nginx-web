FROM alpine:latest

RUN apk --update --no-cache add ca-certificates nginx
RUN apk add php7 php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-phar php7-fileinfo php7-mbstring php7-tokenizer lighttpd php7-common php7-gd php7-xml php7-imap php7-cgi fcgi php7-posix php7-ldap php7-session zip bash curl less vim git tzdata libmcrypt-dev zlib-dev gmp-dev freetype-dev libjpeg-turbo-dev libpng-dev php7-zlib php7-xmlwriter php7-simplexml php7-phar php7-opcache php7-ctype php7-intl php7-bcmath php7-dom mysql-client && apk add -u musl

rm -rf /var/cache/apk/
RUN */5 * * * * php /home/container/webroot/wp-cron.php

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
