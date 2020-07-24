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
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password_digest|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
### Association
- has_one :shipping_address, dependent: :destroy
- has_one :card, optional: true, dependent: :destroy
- has_many :sns_credentials, dependent: :destroy
- has_many :items, dependent: :destroy
- has_many :orders, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
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
|post_code|integer|null: false|
|prefecture|string|null:false|
|city|string|null:false|
|block|string|null:false|
|building|string||
|phone_number|integer||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

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
|category|references|null: false, foreign_key: true|
|brand|string||
|condition|references|null: false, foreign_key: true|
|postage|references|null: false, foreign_key: true|
|shipping_area|references|null: false, foreign_key: { to_table: :prefectures }|
|preparation_period|references|null: false, foreign_key: true|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_one :order
- belongs_to :category
- has_many :item_images dependent: :destroy
- has_many :comments dependent: :destroy
- has_many :likes dependent: :destroy
- belongs_to_active_hash :condition
- belongs_to_active_hash :postage
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :preparation_period
### remarks
- condition,postage,prefecture,shipping_area,shipping_days は ActiveHash を使って選択可能なデータを管理

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
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

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|buyer|references|null: false, foreign_key: { to_table: :users }|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

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