## 初志しか勝たん

[http://calendar-vue-original.com/](http://calendar-vue-original.com/)

### サービス概要
#### こんなことありがち
予定がいろいろ重なると…
[![Image from Gyazo](https://i.gyazo.com/624467be34ade3fb42c4a97f9e331a49.png)](https://gyazo.com/624467be34ade3fb42c4a97f9e331a49)
#### ToDoアプリを使うも
ToDoアプリで期限を設定したけど期限先延ばしにしてしまう‥いつ終わらそう？

#### コンセプト
そこで、
 - はじめに設定した予定は変えれない
 - 今日やることを前の日に設定した予定も見ながら決めれる
カレンダー+ToDoリスト初志貫徹アプリを作成しました

### ページ機能(ログインユーザー)
#### トップページ
[![Image from Gyazo](https://i.gyazo.com/19667613f3b1f044f27d6618f71fc163.png)](https://gyazo.com/19667613f3b1f044f27d6618f71fc163)

#### ガントチャートページ
[![Image from Gyazo](https://i.gyazo.com/33acddf89af680500f644fd346636c0b.png)](https://gyazo.com/33acddf89af680500f644fd346636c0b)

##### する・しないを自在に
ガントチャートに追加したToDoはワンクリックでする・しないを変更できる
[![Image from Gyazo](https://i.gyazo.com/d2c8c603334b6452e75f46f8105730e9.gif)](https://gyazo.com/d2c8c603334b6452e75f46f8105730e9)

カレンダーでカウントされなくなります
[![Image from Gyazo](https://i.gyazo.com/b0ccd6520017665d6e6aaf9c61b8b710.png)](https://gyazo.com/b0ccd6520017665d6e6aaf9c61b8b710)

##### 完了したタスクを確認！
[![Image from Gyazo](https://i.gyazo.com/193f89848e59ad295531b9ea6f55daee.gif)](https://gyazo.com/193f89848e59ad295531b9ea6f55daee)

#### マイページ
##### どんどんタスクをこなしてこう
マイページには初志貫徹率「初志の勝率」が表示されます
[![Image from Gyazo](https://i.gyazo.com/def51773862f4e863cdd4ead74fb517d.png)](https://gyazo.com/def51773862f4e863cdd4ead74fb517d)

### 使用技術
#### バックエンド
  - Ruby 2.6.4
  - Rails 5.2.4.4
  - RSpec 3.10
##### 主な使用Gem
  - devise（ログイン）
  - devise_token_auth (ログイン)
  - cancancan (認可)
  - rails_admin (管理画面)
##### ER図
[![Image from Gyazo](https://i.gyazo.com/fa551aea343b2b0550cf7a965822b7ba.png)](https://gyazo.com/fa551aea343b2b0550cf7a965822b7ba)

#### フロントエンド
  - vue 2.6.12
  - axios 0.20.0
  - vuex 3.5.1
  - vee-validate 3.4.3

#### インフラ
  - Nginx 1.18.0
  - Puma  3.12.6 
  - AWS
    - VPC
    - EC2 (Amazon Linux)
    - RDS (MySQL 8.0.20)
    - Route 53
