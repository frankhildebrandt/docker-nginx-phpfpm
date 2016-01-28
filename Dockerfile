FROM php:7.0-fpm

RUN apt-get update
RUN apt-get install -y nginx
RUN curl https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego -o /usr/local/bin/forego \
     && chmod u+x /usr/local/bin/forego
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN echo "\nerror_log /dev/stdout warn;" >> /etc/nginx/nginx.conf

WORKDIR /

ADD Procfile .
ADD nginx_vhost.conf /etc/nginx/sites-enabled/default
ADD upstream.conf /etc/nginx/conf.d

COPY index.php /var/www/html

EXPOSE 80

CMD ["forego", "start"]