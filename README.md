# README

## 動作確認方法
* config/master.keyに別途お送りしたマスターキーを設定し、以下コマンドを実行してください。
```
$ docker-compose run web bin/rails db:migrate RAILS_ENV=development
$ docker-compose run web bin/rails db:seed RAILS_ENV=development
$ docker-compose up
```

### ログイン方法
* 以下URLにアクセス
	* http://localhost:3000/sessions/new
* 以下テストログインユーザー情報を使ってログインが可能です
    * ユーザーID：test_user
    * パスワード：password