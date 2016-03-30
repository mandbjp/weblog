# Vagrantがドイツ語を話しだしたら


## 参考にしました
- [VagrantからダウンロードしたCentOSのイメージを使ったらドイツ語になったので英語にする](http://websandbugs.hatenablog.jp/entry/2015/10/02/192331)

## 操作
```sh
sudo vi /etc/sysconfig/i18n
# LANGを変える
LANG="en_US.UTF-8"
# 日本語も行けました@centos6.4
LANG="ja_JP.UTF-8"
```


----

_eof_
