FROM debian
ADD mirror.list /etc/apt/sources.list.d/
MAINTAINER Valentina Osipova
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install nginx && \
    apt-get clean && \
    rm -rf /var/www/* && \
    mkdir -p /var/www/osipova.com/img && \
    chmod -R 754 /var/www/osipova.com/ && \
    useradd Valya && \
    groupadd Osipova && \
    usermod -aG Osipova Valya && \
    chown -R Valya:Osipova /var/www/osipova.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/osipova.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user Valya/g' /etc/nginx/nginx.conf
ADD img.jpg /var/www/osipova.com/img/
ADD index.html /var/www/osipova.com/
CMD ["nginx", "-g", "daemon off;"]
