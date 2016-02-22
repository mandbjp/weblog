# heroku上にGoogleDriveAPIを使うアプリをビルドするまでのメモ
すぐ記憶喪失するので。

## 環境まわり
すでに以下の環境が整ってたのでこれが前提。
- Macbook
- Vagrant
- CentoOS6.6
- Rails 4.2.4
- heroku-toolbelt/3.42.36

## TL;DR
- いつかまとめる


## 以下、時系列
- cd ~/myVagrant
- vagrant up
- vagrant ssh
- rails new heroku-drive
- cd heroku-drive
- vi Gemfile
- GoogleのAPIを叩くためのライブラリ
  - [Rails サーバから Google Analytics API で情報を取得する手順 ーー google-api-ruby-client, OAuth](http://bekkou68.hatenablog.com/entry/2014/08/20/222032)
  - Gemfileに2行追加
  - gem 'google-api-client'
  - gem 'signet'
- heroku に対応するためGemfileに2行追加
  - source 'https://rubygems.org'
  - gem "heroku-api"
- bundle install
- heroku login
  - IDとパスワードを入力
- heroku create

(途中更新)

- vagrant のvmの外に出て Vagrantfileを編集
- ポートフォワーディングを設定
```rb
config.vm.network "forwarded_port", guest: 3000, host: 3000
```
- vagrant reload
- vagrant ssh
- 該当ディレクトリに移行
- rails s **-b 0.0.0.0**
  - -bのオプションをよく忘れる
- Macbookのブラウザより http://localhost:3000/ を開くとWelcome aboard.

----

_eof_
