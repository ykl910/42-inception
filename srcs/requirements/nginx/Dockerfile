FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
	apt install nginx -y && \
	mkdir -p /etc/nginx/ssl && \
	apt install openssl -y

RUN openssl req -x509 -nodes -out \
	/etc/nginx/ssl/inception.crt -keyout \
	/etc/nginx/ssl/inception.key \
	-subj "/C=Fr/ST=IDF/L=Paris/O=42/CN=kyang.42.fr/UID=kyang"

RUN mkdir -p /var/run/nginx

COPY conf/default /etc/nginx/sites-available/.

RUN chown -R www-data:www-data /var/www/html

RUN chmod 755 /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]
