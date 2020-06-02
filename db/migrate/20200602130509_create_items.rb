class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                   null: false
      t.text :description,              null: false
      t.references :category,           null: false   #, foreign_key: true
      t.string :brand
      t.references :condition,          null: false   #, foreign_key: true
      t.references :postage,            null: false   #, foreign_key: true
      t.references :shipping_area,      null: false   #, foreign_key: { to_table: :prefectures }
      t.references :preparation_period, null: false   #, foreign_key: true
      t.integer :price,                 null: false
      t.references :user,               null: false   #, foreign_key: true
      t.timestamps
    end
  end
end
