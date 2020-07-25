# Discription
Freemarket_sample_71c

TechCamp 71期夜間・休日コース groupCの最終課題になります。
メルカリ等を参考にして、フリマアプリのクローンサイトを作成しました。

# Features
・ログイン機能
・商品出品機能
・商品購入機能
・クレジットカード登録(Payjp)
・商品詳細検索機能
・商品詳細表示・編集機能
・コメント機能
・いいね機能
・パンくず機能
・商品削除機能
・売り切れ表示機能
・マイページ機能

* Database creation
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
### remarks
- password は bcrypt gem を使って暗号化する
- birthday は date_select を使ってフォーム作成するため date型のカラムを作成

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
### remarks
- condition,postage,prefecture,shipping_area,shipping_days は ActiveHash を使って選択可能なデータを管理

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

11
12
13
14
15