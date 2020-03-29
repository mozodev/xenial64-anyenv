# mozodev/xenial64-anyenv

A vagrant box for web development on ubuntu xenial (virtualbox).

- [anynenv](https://github.com/anyenv/anyenv), [rbenv](https://github.com/rbenv/rbenv), [nodenv](https://github.com/nodenv/nodenv), [phpenv](https://github.com/phpenv/phpenv), [dbdeployer](https://github.com/datacharmer/dbdeployer)
- ruby 2.5.3, bundler, github-pages gem
- node 12.13.0, yarn
- php 5.6.40, 7.3.16, drush-launcher, wp-cli
- mysql 5.7.26, 8.0.19

```zsh
# use
$ vagrant up

# cleanup and build box
$ vagrant ssh
$ /vagrant/cleanup.sh
$ exit
$ vagrant halt && vagrant package --output xenial64-anyenv.box
# add box
$ vagrant add box mozodev/xenial-dev ./xenail64-anyenv.box
```
