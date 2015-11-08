#!/bin/bash
echo "================================================================================"
echo ""
echo "provisioning start"
echo ""
echo "================================================================================"

sudo yum install git -y
sudo yum install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel -y
sudo yum install patch -y
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

# only for vagrant
echo 'export RBENV_ROOT="/home/vagrant/.rbenv"' >> ~/.bash_profile
echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

echo "version of rbenv"
rbenv --version

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# rbenv install -l
rbenv install 2.2.3
rbenv rehash
rbenv global 2.2.3
echo "version of ruby"
ruby -v

# sudo yum install libxml2-devel libxslt-devel -y
# bundle config build.nokogiri --use-system-libraries

gem install --no-ri --no-rdoc rails
gem install bundler
rbenv rehash

source ~/.bash_profile
echo "version of rails"
rails -v

echo "================================================================================"
echo ""
echo "provisioning end"
echo ""
echo "================================================================================"
