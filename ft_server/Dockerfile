FROM debian:buster

COPY src ./root/

RUN apt-get -y update && apt-get -y install nginx \ 
    mariadb-server \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-xml \
    wget

WORKDIR /root/

ENTRYPOINT ["bash", "init.sh"]