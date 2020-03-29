#!/bin/bash

echo $(whoami)
sudo apt-get -y -qq update && sudo apt-get -y -qq upgrade

echo "install anyenv"
git clone https://github.com/anyenv/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
. ~/.bash_profile
yes | anyenv install --init -y

echo "[rbenv] install rbenv dependencies"
sudo apt-get -y -qq install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
echo "[rbenv] install rbenv and versions"
anyenv install rbenv && . ~/.bash_profile
rbenv install 2.5.3 && rbenv rehash && rbenv global 2.5.3
cp /vagrant/gemrc ~/.gemrc && gem install bundler github-pages

echo "[nodenv] install nodenv and versions"
anyenv install nodenv && . ~/.bash_profile
echo yarn >> $NODENV_ROOT/default-packages
nodenv install 12.13.0 && nodenv rehash && nodenv global 12.13.0

echo "[phpenv] install phpenv dependencies"
sudo cp /etc/apt/sources.list /etc/apt/sources.list~
sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && sudo apt-get update
wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i bison_2.7.1.dfsg-1_amd64.deb
sudo apt-get -y -qq install automake libxml2-dev libbz2-dev libcurl4-openssl-dev libsasl2-dev libjpeg-dev libpng-dev libmcrypt-dev libreadline-dev libtidy-dev libxslt-dev re2c pkg-config lemon libkrb5-dev libsqlite3-dev libzip-dev

echo "[phpenv] install phpenv and versions"
anyenv install phpenv && . ~/.bash_profile
phpenv install 5.6.40 && phpenv install 7.3.16 && phpenv rehash && phpenv global 7.3.16

echo "[drush] install drush launcher and drush 8 for drupal 7"
wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar
chmod +x drush.phar && sudo mv drush.phar /usr/local/bin/drush
wget -O drush8.phar https://github.com/drush-ops/drush/releases/download/8.3.2/drush.phar
chmod +x drush8.phar && sudo mv drush8.phar /usr/local/bin/drush8

echo "[wordpress] install wp-cli globally"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp

echo "[mysql] install dbdeployer and dependencies"
sudo apt-get -y -qq install libaio1 libaio-dev
VERSION=1.46.0
OS=linux
origin=https://github.com/datacharmer/dbdeployer/releases/download/v$VERSION
wget -qO- $origin/dbdeployer-$VERSION.$OS.tar.gz | tar xvz
chmod +x dbdeployer-$VERSION.$OS && sudo mv dbdeployer-$VERSION.$OS /usr/local/bin/dbdeployer

# https://downloads.mysql.com/archives/community/ linux - generic
mkdir -p opt/mysql
dbdeployer downloads get-unpack mysql-8.0.19-linux-x86_64-minimal.tar.xz --delete-after-unpack
dbdeployer deploy single 8.0.19
dbdeployer downloads get-unpack mysql-5.7.26.tar.xz --delete-after-unpack
dbdeployer deploy single 5.7.26
