#!/bin/bash

echo 'housekeeping'
sudo apt-get -y -qq update && sudo apt-get -y -qq upgrade
echo 'set timezone to Asia/Seoul'
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

echo "install anyenv"
git clone https://github.com/anyenv/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.profile
echo 'eval "$(anyenv init -)"' >> ~/.profile
. ~/.profile
yes | anyenv install --init -y

echo "[rbenv] install rbenv dependencies"
sudo apt-get -y -qq install autoconf build-essential bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
echo "[rbenv] install rbenv and versions"
anyenv install rbenv && . ~/.profile
rbenv install 2.7.1 && rbenv rehash && rbenv global 2.7.1
rbenv install 2.4.0
echo "gem: --no-document" >> ~/.gemrc && gem install bundler

echo "[nodenv] install nodenv and versions"
anyenv install nodenv && . ~/.profile
echo yarn >> $NODENV_ROOT/default-packages
echo 'export PATH="$(yarn global bin):$PATH"' >> ~/.profile
nodenv install 12.18.1 && nodenv rehash && nodenv global 12.18.1

echo "[phpenv] install phpenv dependencies"
sudo cp /etc/apt/sources.list /etc/apt/sources.list~
sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && sudo apt-get update
wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb && rm libbison-dev_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i bison_2.7.1.dfsg-1_amd64.deb && rm bison_2.7.1.dfsg-1_amd64.deb
sudo apt-get -y -qq install automake libtidy-0.99-0 libxml2-dev libbz2-dev libcurl4-openssl-dev libsasl2-dev libjpeg-dev libpng-dev libmcrypt-dev libreadline-dev libtidy-dev libxslt-dev re2c pkg-config lemon libkrb5-dev libsqlite3-dev libzip-dev libmcrypt4 unzip

echo "[phpenv] install phpenv and versions"
anyenv install phpenv && . ~/.profile
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

echo "[mysql] install 5.7.26, 8.0.19"
# https://downloads.mysql.com/archives/community/ linux - generic
mkdir -p opt/mysql
dbdeployer downloads get-unpack mysql-5.7.26.tar.xz --delete-after-unpack
dbdeployer deploy single 5.7.26
dbdeployer downloads get-unpack mysql-8.0.19-linux-x86_64-minimal.tar.xz --delete-after-unpack
dbdeployer deploy single 8.0.19

echo "[postgresql] install 9.5"
sudo apt-get -y -qq install postgresql && psql -V
sudo runuser -l postgres -c 'psql -c "ALTER USER \"postgres\" WITH PASSWORD '"'"'postgres'"'"';"'
sudo runuser -l postgres -c 'psql -c "CREATE DATABASE project TEMPLATE=\"template0\" ENCODING='"'"'utf8'"'"';"'

echo "[pyenv] install pyenv and 3.8.2, imgp"
anyenv install pyenv && . ~/.profile
pyenv install 3.8.2 && pyenv global 3.8.2
pip install --upgrade pip && pip install python-slugify[unidecode] pillow
curl -LO https://github.com/jarun/imgp/releases/download/v2.7/imgp_2.7-1_ubuntu16.04.amd64.deb
sudo apt -y install ./imgp_2.7-1_ubuntu16.04.amd64.deb && rm ./imgp_2.7-1_ubuntu16.04.amd64.deb
sudo cp /vagrant/scripts/slugify_files.py /usr/local/bin/slugify_files

echo "install latest hugo"
curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
    | grep "browser_download_url.*deb" \
    | grep Linux-64bit \
    | grep extended \
    | cut -d '"' -f 4 \
    | xargs -n 1 sudo curl -sL -o /var/cache/apt/archives/hugo.deb 
sudo dpkg -i /var/cache/apt/archives/hugo.deb 

echo "cleanup"
chmod +x /vagrant/cleanup.sh && sudo /vagrant/cleanup.sh

echo "[test] check versions"
tput setaf 2; echo '#1 [OS]'; tput sgr0;
lsb_release -a
tput setaf 2; echo '#2 [disk]'; tput sgr0;
df -h | grep /dev/sda1
tput setaf 2; echo '#3 [dbdeployer]'; tput sgr0;
dbdeployer versions
tput setaf 2; echo '#4 [postgresql]'; tput sgr0;
psql -V
tput setaf 2; echo '#5 [anyenv]'; tput sgr0;
anyenv version