FROM circleci/php:7.4.2-apache-node-browsers

RUN sudo apt-get update; \
    sudo apt-get -y install \
    default-mysql-client \
    libxml2-dev \
    libcurl3-dev \
    libpng-dev \
    libjpeg-dev

RUN sudo docker-php-ext-install gd pdo_mysql zip mysqli opcache

# Installing WP CLI
RUN sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    sudo chmod +rx wp-cli.phar; \
    sudo mv wp-cli.phar /usr/local/bin/wp

# Installing Composer
RUN sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    sudo php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer; \
    sudo php -r "unlink('composer-setup.php');"