FROM debian:bullseye

RUN apt update -y
RUN apt install nginx -y

EXPOSE 443

RUN mkdir -p /etc/nginx/ssl

RUN apt install openssl -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FI/ST=Southern Finland/L=Helsinki/O=42/OU=Hive/CN=emajuri.42.fr"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]
