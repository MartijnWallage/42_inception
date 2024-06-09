FROM php:7.4-apache

COPY adminer-4.8.1.php /var/www/html/index.php

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
