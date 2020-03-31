# mozodev/xenial64-anyenv

A vagrant box for web development on ubuntu xenial (virtualbox).

- [anynenv](https://github.com/anyenv/anyenv)
- [rbenv](https://github.com/rbenv/rbenv) > ruby 2.5.3, bundler, github-pages gem
- [nodenv](https://github.com/nodenv/nodenv) > node 12.13.0, yarn
- [phpenv](https://github.com/phpenv/phpenv) > php 5.6.40, 7.3.16, drush-launcher, wp-cli
- [dbdeployer](https://github.com/datacharmer/dbdeployer) > mysql 5.7.26, 8.0.19

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
