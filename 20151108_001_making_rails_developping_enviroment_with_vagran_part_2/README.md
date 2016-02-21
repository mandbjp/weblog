# vagrant で作るrails開発環境、その2

## 概要
- キーワードだけ並べると、以下の様な環境を作る
  - vagrant
  - CentOS 6.6 64bit
  - ruby 2.2.3
  - rails 最新ver
- これまでの記事
  - [その1](../20151101_001/README.md)

## 今回のゴール
- vagrant上でrubyとrailsを構築
  - スクリプトの動作を一応確認
  - 基本的にshellスクリプト一発実行でインストールするだけ
  - その際CentOSとMacの共有フォルダを使うことで、CentOSに簡単にファイルを送る

## 参考文献
- [rails環境構築（CentOS + ruby on rails）](http://qiita.com/shinyashikis@github/items/3501c5f7f71a8e345c3d)

## いきなり言い訳
- vagrantには **プロビジョニング** という機能があってVagrantFileに書き足すことで```vagrant up```したタイミングでシェルを実行するような便利機能がある
- 今回は、CentOS上の vagrantユーザーに対して環境構築するためプロビジョニングは使わず、カッコ悪いが起動後にバッチを流してインストールする

## 一発インストールスクリプト
- [provision_rails.sh](provision_rails.sh)

```sh
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
```

## ざっと流れだけ備忘録
1. 以下ツールをyumでインストール
  - git, gcc, openssl
  - その他色々
2. rbenvをgithubからcloneしてインストール
3. ```bash_profile```にいろいろ設定を記入
  - 14行目だけ気持ちが悪い。改善したい。
4. rbenv で必要なバージョンのrubyをダウンロードしてバージョン切り替えができるような設定かな > 22-26行目
5. railsインストール
6. おわり。

## vagrant上で動作させるためには
- その1の手順でやっている場合、VagrantFileは以下ディレクトリにあるはず。
  - ```~/myVagrant/centos6_6/```
- そのディレクトリに ```provision_rails.sh``` をコピーしておく
- VagrantFileのあるディレクトリは、CentOS内の ```/vagrnat``` のディレクトリと共有されている
- CentOSから ```/bin/bash /vagrant/provision_rails.sh``` で実行すればok

----

今回は手抜きだなぁ..

----

_eof_
