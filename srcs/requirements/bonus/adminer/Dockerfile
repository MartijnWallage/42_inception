FROM debian:bullseye-slim

# Install PHP and required extensions
RUN apt-get update && apt-get install -y \
    php-cli \
    php-mysql \
    php-zip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY adminer-4.8.1.php /var/www/html/index.php

WORKDIR /var/www/html

EXPOSE 8080

CMD ["php", "-d", "display_errors=1", "-S", "0.0.0.0:8080"]