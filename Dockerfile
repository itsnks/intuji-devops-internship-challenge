FROM php:7.4-apache
LABEL Author="Nikesh"
LABEL Project="nikeshhh/phpapp-intuji"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt install unzip apache2 -y
CMD [ "/usr/sbin/apache2ctl","-D","FOREGROUND" ]
EXPOSE 80

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html/
COPY index.php /var/www/html/

# Run composer commands
RUN composer require silarhi/hello-world
RUN composer update silarhi/hello-world
