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
 - はじめに設定した予定は変えれない（初志至上主義）
 - 今日やることを前の日に設定した予定も見ながら決めれる
カレンダー+ToDoリスト初志貫徹アプリ「初志しか勝たん」を作成しました

### ページ機能(ログインユーザー)

| トップページ                                                         | マイページ                                                                                               |
| :------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| [![Image from Gyazo](https://i.gyazo.com/19667613f3b1f044f27d6618f71fc163.png)](https://gyazo.com/19667613f3b1f044f27d6618f71fc163) | [![Image from Gyazo](https://i.gyazo.com/7a2237a3227467b71c96db6c510c45af.png)](https://gyazo.com/7a2237a3227467b71c96db6c510c45af)                                   |
| ガントチャートページで登録した予定の数を表示します | 初めに設定した期限のまま完了したタスクは「初志の勝率」として表示されます |

<br>

| ガントチャートページ : ToDoカードの作成                                                        | ガントチャートページ : ガントチャート（風カレンダー）へのToDoカードの登録                                                                                               |
| :------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| [![Image from Gyazo](https://i.gyazo.com/588dc9f9b2c9eb590e63f42cd85b282a.gif)](https://gyazo.com/588dc9f9b2c9eb590e63f42cd85b282a) | [![Image from Gyazo](https://i.gyazo.com/b81526e9d7e8d8eb1010bda2e23ca7b6.gif)](https://gyazo.com/b81526e9d7e8d8eb1010bda2e23ca7b6)                                   |
| ToDoカードを作成できます | ガントチャート（風カレンダー）にToDoカードを追加できます |

<br>

| ガントチャートページ : ToDoタスクのする・しないの切り替え                                                        | ガントチャートページ : 完了したタスクを確認                                                                                               |
| :------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| [![Image from Gyazo](https://i.gyazo.com/d2c8c603334b6452e75f46f8105730e9.gif)](https://gyazo.com/d2c8c603334b6452e75f46f8105730e9) | [![Image from Gyazo](https://i.gyazo.com/193f89848e59ad295531b9ea6f55daee.gif)](https://gyazo.com/193f89848e59ad295531b9ea6f55daee)                                   |
| ワンクリックでToDoタスクのする・しないを切り替えることができます<br>しない状態（透明）のToDoカードはトップページのカレンダーでカウントされません。 | 完了したタスクを確認することができます |

<br>

### 初志貫徹支援機能
初志貫徹を支援する機能がこちら

| カウントダウン機能                                                        | 初志貫徹できなかったToDoカードたち                                                                                               |
| :------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| [![Image from Gyazo](https://i.gyazo.com/0a208684b6bb930d197fa258f38f86db.png)](https://gyazo.com/0a208684b6bb930d197fa258f38f86db) | [![Image from Gyazo](https://i.gyazo.com/2073d8ee32aa6ce0ba271b6de8072f21.png)](https://gyazo.com/2073d8ee32aa6ce0ba271b6de8072f21)                                   |
| その日期限のToDoタスクがある時、カウントダウンが表示されます。 | 初めに設定した期限を過ぎてしまったカードは残り続けます‥👻 |

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
<img src="https://i.gyazo.com/fa551aea343b2b0550cf7a965822b7ba.png" width="600" height="600">

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

[![Image from Gyazo](https://i.gyazo.com/aebe397ae8b22f55d5bd588401cca8d5.png)](https://gyazo.com/aebe397ae8b22f55d5bd588401cca8d5)
