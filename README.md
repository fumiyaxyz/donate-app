# README

# アプリケーション名: Donate-App
困っている人と支援したい人をつなぐためのサイトです。困っていれば支援の申し込みをします。もし支援者がいれば支援を受けることができます。逆に寄付を求めている人の一覧をみて助けてあげたい人がいれば寄付をすることができます。

# なぜこのアプリケーションを作ろうと思ったか？
貧困による格差が小さくなって欲しいという思いから作りました。僕は今まで東アジアの国を４つ回りました。観光地だけでなくスラムにも行きました。その中で気づいたことは、スラムの子供たちも携帯を持っておりインターネットにアクセスできるということです。実際に聞いたところ80%ほどは携帯を持っているということでした。また、ネットで(スラム　寄付)と検索してもボランティア団体やNPOに寄付することはできても直接貧しい人たちに寄付することはできません。そこで人と人が直接繋がれる寄付型サイトの着想を得ました。まずは、日本版サイトを作り最終的には英語や現地の言を取り入れていきたいと思います。

# 使用言語、開発環境
Ruby/Ruby on Rails/Haml/SCSS/Javascripit/VScode


# インフラ環境

# 実装機能一覧
・ユーザー登録、ログイン、ログアウト機能(devise)
・登録時のウィザード機能
・記事一覧表示機能
・記事詳細表示機能
・記事投稿機能
・画像ファイルのアップロード機能
・クレジット決済機能

今後の実装予定
・単体テスト
・結合テスト
・記事編集機能(3/10)
・記事削除機能(3/10)
・コメント機能(3/10)
・コメント機能の非同期
・いいね機能
・検索機能
・プレビュー機能
・AWSを利用
・dockerを組み込む
・circleCIを組み込む

# 使用方法
トップ画面です。
<img width="722" alt="スクリーンショット 2021-03-10 21 15 22" src="https://user-images.githubusercontent.com/78077570/110627796-bdfe8500-81e5-11eb-953a-ca3858b1615e.png">

ログインした状態でヘッダーにある「支援に申し込む」を押して情報を入力します。送信を押すと今入力した情報がトップページの一覧の中に更新されます。
<img width="722" alt="スクリーンショット 2021-03-10 21 21 06" src="https://user-images.githubusercontent.com/78077570/110628606-9360fc00-81e6-11eb-97b8-e112adb144b4.png">

一覧にある一つの枠を押すと詳細ページに移動します。
そのページには編集、戻る、寄付、コメントのボタンがある。実際にコメントすることもできます。
<img width="722" alt="スクリーンショット 2021-03-10 21 36 52" src="https://user-images.githubusercontent.com/78077570/110630485-bf7d7c80-81e8-11eb-87f4-06cbb6ed52c1.png">

寄付ボタンを押すと寄付ページに移動します。そこで自分が支援したい分だけ寄付できる。寄付した分は詳細ページのこれまでの支援金額に加算されます。
<img width="722" alt="スクリーンショット 2021-03-10 21 42 13" src="https://user-images.githubusercontent.com/78077570/110631116-85f94100-81e9-11eb-8b27-cfc14ea247be.png">

またアカウント作成ではウィザード形式を利用して住所まで登録しています。その時、アクティブハッシュを用いました。
<img width="722" alt="スクリーンショット 2021-03-10 21 47 18" src="https://user-images.githubusercontent.com/78077570/110631736-31a29100-81ea-11eb-8ed9-92fad253f538.png">
# テーブル設計

## ER図
<img width="906" alt="スクリーンショット 2021-03-10 21 50 34" src="https://user-images.githubusercontent.com/78077570/110632160-a675cb00-81ea-11eb-96da-7f89e4553746.png">


## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false ,unique: true|
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| phone_number       | string | null: false |


### Association

- has_many :supports
- has_many :orders

## addresses テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| postal_code     | string     | null: false |
| prefecture_id   | integer    | null: false |
| house_number    | string     | null: false |
| building_number | string     |             |
| user            | references | null: false, foreign_key: true |


### Association

- belongs_to :user

## supports テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| item            | string     | null: false |
| price           | integer    | null: false |
| reason          | text       | null: false |
| status          | text       | null: false |
| user            | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one_attached :image
- has_many :orders


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :support
- belongs_to :user

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| support | references | null: false, foreign_key: true |

### Association

- belongs_to :support
- belongs_to :user