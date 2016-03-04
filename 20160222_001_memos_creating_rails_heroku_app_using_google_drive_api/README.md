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

- herokuにpushしてみる。vagrant内、railsのディレクトリにて
- git init
- git add .
- git commit -m "message"
- git push heroku master
- heroku create
- git push heroku master
- *Detected sqlite3 gem which is not supported on Heroku.* と怒られるのでGemfileから該当行をコメントアウト
  - # gem 'sqlite3'
- *An error occurred while installing Ruby ruby-2.2.4  For supported Ruby versions...* と怒られる。どうやらruby2.1にしなければならないようだ。

- これに方向転換
  - [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby)
```sh
git clone https://github.com/heroku/ruby-getting-started.git
cd ruby-getting-started/
heroku create
git push heroku master
```

- herokuのバージョンに合わせるために、rubyのバージョンを2.1.8にする
  - `rbenv install 2.1.8 && rbenv global 2.1.8 `
  - ちょっと時間かかる
- bundle などもインストール
```sh
gem install --no-ri --no-rdoc rails
gem install bundler
rbenv rehash
```

- 結局getstarted リポジトリのGemfileがruby 2.2.4なので、それに合わせる
```sh
rbenv install 2.2.4 && rbenv global 2.2.4
gem install --no-ri --no-rdoc rails
gem install bundler
rbenv rehash
```
- `bundle install`をするとエラーが起きる。PostgreSQL を要求されているがDBは使わないのでGemfileをコメントアウト
- 
- ExecJS::RuntimeUnavailable: Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes.
- と出たので、gem install therubyracerをGemfileに追加
```sh
# https://github.com/sstephenson/execjs
gem 'therubyracer'
```
- 結局PostgreSQL必要っぽいのでここを参考にする
- [http://qiita.com/yuyakato/items/d9b734152c27a5078484](http://qiita.com/yuyakato/items/d9b734152c27a5078484)
- `sudo yum install postgresql postgresql-devel`
- これでやっと `rails g model Project`、`rails g controller Projects` ができるようになった
- ローカルテストするために、PostgreSQLサーバを入れる `sudo yum install postgresql-server  `
- 参考 http://www.server-world.info/query?os=CentOS_6&p=postgresql
```sh
sudo yum install postgresql-server
sudo /etc/rc.d/init.d/postgresql initdb
```
- なぜかPostgreSQLはドイツ語を話す。いつか直す。
- `sudo service postgresql *start / stop / status*`
- ポスグレを起動したら以下3コマンドを実施
```sh
vagrant$ sudo su - postgres
postgres$ createuser --superuser vagrant
postgres$ exit
vagrant$ psql -l
(テーブル一覧が表示される)
```
- 引用元 (http://qiita.com/yuyakato/items/d9b734152c27a5078484)[http://qiita.com/yuyakato/items/d9b734152c27a5078484]
  
- rails g controller Projects
- app/view/welcome/index.erb をapp/view/projects にコピーする
- ちょっといじる
- ```git add . && git commit -m "comit" && git push heroku master``` して確認
----
- ここを参考にGoogle Driveをやってみる
- [https://blog.hello-world.jp.net/ruby/2717/](https://blog.hello-world.jp.net/ruby/2717/)
- 


----

_eof_
