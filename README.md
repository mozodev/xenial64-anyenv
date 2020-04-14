# mozodev/xenial64-anyenv

A vagrant box for web development on ubuntu xenial (virtualbox).

- [anynenv](https://github.com/anyenv/anyenv)
- [rbenv](https://github.com/rbenv/rbenv) > ruby 2.5.3, bundler, github-pages gem
- [nodenv](https://github.com/nodenv/nodenv) > node 12.13.0, yarn
- [phpenv](https://github.com/phpenv/phpenv) > php 5.6.40, 7.3.16, drush-launcher, wp-cli
- [dbdeployer](https://github.com/datacharmer/dbdeployer) > mysql 5.7.26, 8.0.19
- [pyenv](https://github.com/pyenv/pyenv) > python 3.8.2, python-slugify[unidecode] pillow, imgp 2.7.1
- [homebrew on linux](https://docs.brew.sh/Homebrew-on-Linux)
- [hugo](https://github.com/gohugoio/hugo) v0.69.0

```zsh
# use
$ vagrant up

# cleanup and build box
$ vagrant ssh
$ /vagrant/cleanup.sh
$ exit
$ vagrant halt && vagrant package --output xenial64-anyenv.box
# add box
$ vagrant add box mozodev/xenial64-anyenv ./xenail64-anyenv.box
```

## [mysql] [dbdeployer](https://github.com/datacharmer/dbdeployer/)

DBdeployer is a tool that deploys MySQL database servers easily (sandboxed).
documentation: <https://www.dbdeployer.com/>

```bash
# install specific mysql version
vagrant@xenial64-anyenv:~$ dbdeployer downloads get-unpack mysql-5.7.26.tar.xz --delete-after-unpack
vagrant@xenial64-anyenv:~$ dbdeployer deploy single 5.7.26

# status, start, stop, restart, use
vagrant@xenial64-anyenv:~$ ~/sandboxes/msb_5_7_26/status
vagrant@xenial64-anyenv:~$ ~/sandboxes/msb_5_7_26/start
vagrant@xenial64-anyenv:~$ ~/sandboxes/msb_5_7_26/stop
vagrant@xenial64-anyenv:~$ ~/sandboxes/msb_5_7_26/restart
vagrant@xenial64-anyenv:~$ ~/sandboxes/msb_5_7_26/use -e 'drop database test; create database ieas21;'

[client]
user               = root
password           = msandbox
port               = 5726
socket             = /tmp/mysql_sandbox5726.sock
```

## [python] [imgp](https://github.com/jarun/imgp)

High-performance CLI batch image resizer & rotator

```bash
vagrant@xenial64-anyenv:~$ imgp -x 800x800 /vagrant/some-directory | /vagrant/some-file.jpg
```

## [python] [python-slugify[unicode]](https://github.com/un33k/python-slugify)

수많은 파일을 프로젝트에 사용해야하는데 파일명이 한글... gui 프로그램이나 bash script도 좋은데 한글도 
음역([transliteration](https://www.dictionary.com/browse/transliteration#): 소리나는데로 읽어서 영문으로 표기) 변환해서
url에 사용하기 좋은 형태로 한번에 변환할 수 있습니다.

```bash
vagrant@xenial64-anyenv:~$ /usr/local/bin/slugify_files /vagrant/some-directory
```