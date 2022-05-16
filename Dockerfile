FROM alpine:edge

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community" >> /etc/apk/repositories
RUN apk --update --no-cache add ca-certificates nginx
RUN apk add php8 php8-fpm php8-pecl-mcrypt php8-soap php8-openssl php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip php8-mysqli php8-sqlite3 php8-apcu php8-pdo_pgsql php8-bcmath php8-gd php8-odbc php8-pdo_mysql php8-pdo_sqlite php8-gettext php8-xmlreader php8-bz2 php8-iconv php8-pdo_dblib php8-curl php8-ctype php8-phar php8-fileinfo php8-mbstring php8-tokenizer lighttpd php8-common php8-gd php8-xml php8-imap php8-cgi fcgi php8-posix php8-ldap php8-session zip bash curl less vim git tzdata libmcrypt-dev zlib-dev gmp-dev freetype-dev libjpeg-turbo-dev libpng-dev php8-zlib php8-xmlwriter php8-simplexml php8-phar php8-opcache php8-ctype php8-intl php8-bcmath php8-dom mysql-client musl sqlite


USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
