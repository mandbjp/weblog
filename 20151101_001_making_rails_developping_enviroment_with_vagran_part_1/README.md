# vagrant で作るrails開発環境、その1

## 概要
- キーワードだけ並べると、以下の様な環境を作る
  - vagrant
  - CentOS 6.6 64bit
  - ruby 2.2.3
  - rails 最新ver

## 今日のゴール
- vagrantを使ってVirtualBox上にCentOS 6.6環境を構築する
- 作った環境へsshで接続してみる

## 前提
- このメモはMacとbrew caskを使って構築する
  - [HomeBrew Cask とは](https://www.google.co.jp/search?q=brew+cask&ie=utf-8&oe=utf-8)
- この記事の知識は、dotinstall様から習いました
  - [vagrant入門 - ドットインストール](http://dotinstall.com/lessons/basic_vagrant)

## 必要なツールをインストール
- brew cask install で以下パッケージをインストール
  - virtualbox
  ```sh
  brew cask install virtualbox
  ```
  - vagrant
  ```sh
  brew cask install vagrant
  ```

## vagrantでCentOS 6.6をダウンロード
- OSのテンプレ(box)をダウンロードする
  - コマンドの使い方
    - vagrant box add {box名} {テンプレURL}
  - コマンド
  ```sh
  vagrant box add centos6_6 https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.0.0/centos-6.6-x86_64.box
  ```
  - vagrant予備知識
    - 非公式ではあるが、vagrantテンプレ(box)は以下サイトでたくさん公開されている
      - [Vagrantbox.es](http://www.vagrantbox.es/)

## CentOS 6.6の構築準備
- 仮想OSをインストールするディレクトリを作成
- 自分はホーム直下にmyVagrantというディレクトリを作って、その配下に各種OSを保存することにした
  - ~/myVagrantの作成
  ```sh
  mkdir ~/myVagrant && cd $_
  ```
- 今回のターゲットOSの保存先ディレクトリ作成して移動
```sh
mkdir centos6_6 && cd $_
```
- vagrantの構築準備
  - コマンドの使い方
    - vagrant init {box名}
  - コマンド
  ```sh
  vagrant init centos6_6
  ```
  - VagrantFileというファイルが作成されていることを確認

## CentOS 6.6構築・起動
- コマンド
```sh
vangrant up
```
- 初回up時にboxからOSが構築される
  - そのため少し時間がかかる
- 構築が完了すると、同一ディレクトリに .vagrant というディレクトリが作成される

## CentOS 6.6に接続
- vangrant up したディレクトリにて
```sh
vagrant ssh
```
- [vagrant@localhost ~]$ と表示されればok
- exit でsshから切断

## vagrantでCentOS 6.6の停止
- vangrant up したディレクトリにて
```sh
vagrant halt
```

----
#### その他参考文献
- [mkdirとcdを同時に - Qiita](http://qiita.com/akokubu/items/d577d0d8ccc6464286c1)
- [みんなhomebrew-caskって知ってるか？ - Qiita](http://qiita.com/ryurock/items/1432578d364985f6cb06)
- [vagrantとは - Google](https://www.google.co.jp/search?q=vagrant+%E3%81%A8%E3%81%AF&ie=utf-8&oe=utf-8)

----

_eof_
