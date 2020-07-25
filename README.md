# Title
Freemarket_sample_71c

# Description
TechCamp 71期夜間・休日コース groupCの最終課題になります。
メルカリ等を参考にして、フリマアプリのクローンサイトを作成しました。

[本番環境](http://54.250.23.227/)

- Basic Authentication
  - id: admin
  - password: 2222

# Features
- ログイン機能
- 商品出品機能
- 商品購入機能
- クレジットカード登録(Payjp)
- 商品詳細検索機能
- 商品詳細表示・編集機能
- コメント機能
- いいね機能
- パンくず機能
- 商品削除機能
- 売り切れ表示機能
- マイページ機能

# Demo
- TOPページ
![c77d16e6c31d78fb5ade1d7e6feb9a9f](https://user-images.githubusercontent.com/63528317/88456482-14b68900-ceb9-11ea-9f88-53def61425d7.jpg)

- マイページ
<img width="1063" alt="3f3a416ba4ce56c458a283ff20ca08fb" src="https://user-images.githubusercontent.com/63528317/88456451-d3be7480-ceb8-11ea-9202-41c6cb6978bd.png">

- 商品を出品する
![c4bf7c14cd6af0a02f7d7f8bcdb28986](https://user-images.githubusercontent.com/63528317/88456529-58a98e00-ceb9-11ea-91ef-8d11e23d4113.gif)

- 商品を検索する
![ce5dcfd87bc3017af9d132317b73a00b](https://user-images.githubusercontent.com/63528317/88456585-90183a80-ceb9-11ea-82ab-25707334d907.gif)

- 商品詳細ページから購入画面まで移動
![211003fb53c6b3109521145af05b38a0](https://user-images.githubusercontent.com/63528317/88456636-1cc2f880-ceba-11ea-8ad8-57cb59ffb841.gif)

- 商品を購入する
![ddb1a0e04c1e2a00a5c14544127610ba (2)](https://user-images.githubusercontent.com/63528317/88456682-8ba05180-ceba-11ea-8f0a-5a2972c27c03.gif)

- 気に入った商品に「いいね」とコメントをする
![e12fa65d356ff18534bb458fe52a2ccd](https://user-images.githubusercontent.com/63528317/88456696-c3a79480-ceba-11ea-8621-cdae0953b5b2.gif)


# Database creation

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|default: ""|
|email|string|null: false, unique: true|default: ""|
|encrypted_password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|
|first_name_kana|string|
|birthday|date|
### Association
- has_one :shipping_address, dependent: :destroy
- has_one :card, dependent: :destroy
- has_many :sns_credentials, dependent: :destroy
- has_many :items, dependent: :destroy
- has_many :seller_items, class_name: 'Item', :foreign_key => 'seller_id'
- has_many :buyer_items, class_name: 'Item', :foreign_key => 'buyer_id'
- has_many :items, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :items, through: :likes

## shipping_addressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_code|string|null: false|
|prefecture|string|null:false|
|city|string|null:false|
|block|string|null:false|
|building|string||
|phone_number|string||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user, optional: true

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_token|string|null: false|
|user|references|forign_key: true|
### Association
- belongs_to :user, optional: true

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string||
|provider|string||
|user|references|foreign_key: true|
### Association
- belongs_to :user, optional: true

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|category|references|null: false|
|condition|references|null: false|
|postage|references|null: false|
|prefecture|references|null: false|
|preparation_period|references|null: false|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|
|shipping_method|references|null: false|
|seller|references|foreign_key: {to_table: :users}|
|buyer|references|foreign_key: {to_table: :users}|

### Association
- has_many :users, through: :likes
- belongs_to :seller, class_name: "User", :foreign_key => 'seller_id'
- belongs_to :buyer, class_name: "User", :foreign_key => 'buyer_id', optional: true
- belongs_to :category
- has_many :item_images dependent: :destroy
- has_many :comments dependent: :destroy
- has_many :likes dependent: :destroy
- belongs_to_active_hash :condition
- belongs_to_active_hash :postage
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :preparation_period
- belongs_to_active_hash :shipping_method

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many :items
- has_ancestry

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item
