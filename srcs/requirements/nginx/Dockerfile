# Use the official Alpine base image
FROM alpine:3.14

RUN apk update && apk upgrade && apk add \
    openssl \
    nginx \
    curl \
    vim \
    sudo

EXPOSE 443 80

CMD ["nginx", "-g", "daemon off;"]