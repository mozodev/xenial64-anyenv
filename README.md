# mozodev/xenial-dev

A vagrant box for web development on ubuntu xenial (virtualbox).

- anynenv, rbenv, nodenv, phpenv, dbdeployer
- ruby 2.5.3, bundler, github-pages gem
- node 12.13.0, yarn
- php 5.6.40, 7.3.16, drush-launcher, wp-cli
- mysql 5.7.26, 8.0.19

```zsh
$ nano Vagrantfile

# use
$ vagrant up

# cleanup and build box
$ vagrant ssh
$ /vagrant/cleanup.sh
$ exit
$ vagrant halt && vagrant package --output xenial-dev.box
# add box
$ vagrant add box mozodev/xenial-dev ./xenail-dev.box
```
