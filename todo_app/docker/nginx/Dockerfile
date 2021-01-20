FROM nginx:alpine

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

RUN apk --update --no-cache add openssl \
    && apk add vim \
    # create root dir
    && mkdir -p /var/www/html && chmod 755 -R /var/www/html \
    # create sock dir
    && mkdir -p /var/run/sock
