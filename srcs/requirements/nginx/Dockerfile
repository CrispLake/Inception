FROM debian:bullseye

RUN apt update
RUN apt install nginx -y

#<Remove
RUN apt install vim -y
#Remove>

RUN mkdir -p /etc/nginx/ssl

RUN apt install openssl -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FI/ST=Southern Finland/L=Helsinki/CN=emajuri.42.fr/UID=emajuri"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]
