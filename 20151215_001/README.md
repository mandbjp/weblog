# herokuを始めた時の備忘録
かなりメモ。

## heroku登録までに与える個人情報
- 名前
- メールアドレス
- SMS認証のための電話番号
- この時点では不要だが、無料DBを使うためにはクレジットカード情報が必要らしい

## herokuを始める際に参考にしたサイト
- [初心者でも15分で公開できるHerokuのはじめかた](http://developers.mobage.jp/blog/how-to-use-for-beginners-heroku)
- [無料枠内でのHerokuの準備とデプロイ（Mac 10 + Rails 4.2 + MySQL 5.6）](http://ruby-rails.hatenadiary.com/entry/20150314/1426332751)
- [Vagrant 上の CentOS 6.5 から Heroku を使うには - Qiita](http://qiita.com/satomin/items/ea5e1b144620ffc4acca)
  - 自分の場合は```.bash_profile```だったので、
```sh
wget -qO- https://toolbelt.heroku.com/install.sh | sh
echo 'PATH="/usr/local/heroku/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

## 駄文
- `Hero` + `Haiku` => `heroku` というのが有力な由来らしい

----

_eof_
