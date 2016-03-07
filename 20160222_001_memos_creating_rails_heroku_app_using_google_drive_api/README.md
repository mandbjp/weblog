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
- 追加分. railsローカル実行するためにプロジェクト用のdbを作成する
```sh
vagrant$ createdb ** ralis_project_name **
rake db:migrate
```
- これでローカル実行が可能になる。herokuのローカル実行は `heroku local -p 3000` でok
  
- rails g controller Projects
- app/view/welcome/index.erb をapp/view/projects にコピーする
- ちょっといじる
- ```git add . && git commit -m "comit" && git push heroku master``` して確認
----
- sinatra に浮気してみる
- [http://totutotu.hatenablog.com/entry/2015/06/10/Heroku%E3%81%AB%E9%80%9F%E6%94%BB%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8BSinatra%E3%82%A2%E3%83%97%E3%83%AA%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88%E3%82%92%E3%81%A4](Herokuに速攻デプロイするSinatraアプリテンプレートをつくる #1)
```sh
bundle init
mkdir views
touch app.rb Procfile views/index.haml
```
- Gemfile, app.rg, Profileを編集（サイトの通り）
- Gemfileには以下を追加する
```rb
ruby '2.2.4'
gem 'sinatra'
gem 'therubyracer'
```
- bundle系、heroku系
```sh
bundle install
get init
heroku create
git add . ; git commit -m "commit" ; git push heroku master
```
- さくっと動いた。
- 結果的にsinatraでDriveAPIが出来たので要素だけ。
- Gemfile
```rb
# A sample Gemfile
source "https://rubygems.org"
ruby '2.2.4'

# gem "rails"

# Assets
gem 'sinatra'
gem 'therubyracer'
gem 'haml'
gem 'sass'
gem 'coffee-script'
gem 'google-api-client', '0.9'

group :development do
  gem 'foreman'
end
```
- `client_secret.json` をGemfileと同じディレクトリに作成
- app.rb
```rb
require 'bundler/setup'
require 'sinatra'

require 'haml'
require 'sass'
require 'coffee-script'

require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

client_secrets = Google::APIClient::ClientSecrets.load
auth_client = client_secrets.to_authorization
auth_client.update!(
  :scope => 'https://www.googleapis.com/auth/drive.readonly',
  :redirect_uri => 'https://_____.herokuapp.com/oauth2callback'
)

get '/' do
  auth_uri = auth_client.authorization_uri.to_s
  @url = auth_uri
  haml :index
end


get '/oauth2callback' do
  auth_code = params['code']
  auth_client.code = auth_code
  auth_client.fetch_access_token!

  service = Google::Apis::DriveV2::DriveService.new
  service.authorization = auth_client
  response = service.list_files
  @files = response

  haml :oauth2callback
end
```

- view/oauth2callback.haml
```haml
:sass
  body
    color: #757575
  h1
    color: #424242
  a
    color: #01579B
    text-decoration: none
    &:hover
      text-decoration: underline

%h1 Drive API Success!
%h2 Your file list:
%ol
  - @files.items.each do |file|
    %li
      %a{:href => "#{file.alternate_link}", :target => '_blank'}
        %img{:src => "#{file.icon_link}"}
        #{file.title}
```

## 結果
- sinatraがシンプルで扱いやすい。
- Google OAuth2.0 周りは公式を参照
- [https://developers.google.com/identity/protocols/OAuth2WebServer#overview](Using OAuth 2.0 for Web Server Applications)
- hamlで変数を表示するには`"#{file.title}"`という感じ。**シングルクォーテーションとダブルクォーテーションは区別される**

----

_eof_
