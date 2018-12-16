FROM       nginx:1.11
MAINTAINER Michel RABEMANANTSOA <hmichel.rabemanantsoa@gmail.com>

RUN rm /etc/nginx/nginx.conf /etc/nginx/mime.types

RUN apt-get install curl

COPY nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh

COPY nginx.conf /etc/nginx/

COPY vhosts/default.conf /etc/nginx/conf.d/

COPY html/ /usr/share/nginx/html/

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/nginx-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]