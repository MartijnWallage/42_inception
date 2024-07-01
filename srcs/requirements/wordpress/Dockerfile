FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get -y install wget unzip php7.4 php-fpm php-mysql mariadb-client tini \
    php-redis && rm -rf /var/lib/apt/lists/*
RUN wget https://wordpress.org/latest.zip -P /var/www

COPY ./conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN cd var/www && unzip latest.zip && rm latest.zip

RUN chown -R root:root /var/www && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/auto-config.sh /auto-config.sh
RUN chmod +x /auto-config.sh

ENTRYPOINT [ "tini", "--", "/auto-config.sh" ]
