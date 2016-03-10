# Python, JavaでWebページの自動ログインの実装など、cookieをリクエストで持ち回す方法


## Pythonでやる場合
- [Requests: HTTP for Humans](http://docs.python-requests.org/en/master/)を使うと簡単
```py
import requests
with requests.session() as session:
  data={"id": "ham", "password": "egg"}
  session.post("http://example.com/login", data=data)
  # ログインされて何かのcookieを受信する
  res = session.get("http://example.com/my-task")
  # PyQuery か何かを使ってログイン後のページの情報を取得する
```

## Javaでやる場合
- 調べてみると幾つかワードが出てくる
  - HttpClient
  - Jakarta Commons → [End of Life](http://hc.apache.org/httpclient-3.x/)
- まだ実践してないので参考サイトだけ貼っておく。
- [HttpClientでのCookieの扱い(HttpClient3.0-rc3)](http://www.fireproject.jp/feature/uzumi/httpclient/cookie.html)
- [Jakarta Commonsによるネットワークプログラミング](http://www.visards.co.jp/java/net/net06.html)


----

_eof_
