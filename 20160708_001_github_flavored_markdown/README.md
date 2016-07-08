# GitHub Flavored Markdown でチェックボックス作った時にどう更新されるか知りたい。


## 参考にしました
- [[新機能] GitHub Flavored Markdown でタスクリストを作れるようになりました](http://github.kyanny.me/1375-task-lists-in-gfm-issues-pulls-comments)

## 以下リスト
- [ ] これが一つのチェック項目になります
- [ ] Markdown のリスト記法に続けて書く必要があります
- [ ] 他の **Markdown 記法**も使えます (GFM の @mentions, #1234 なども可能)
- [ ] これは未完了のタスク
- [x] こちらは完了済みのタスク

## やってみた結果。
- Readme.md ではチェックがdisabled となるので、チェックボックスにしてもファイルは更新されないようだ。
- issueでは機能する

----

_eof_
