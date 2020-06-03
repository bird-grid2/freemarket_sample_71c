class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                   null: false
      t.text :description,              null: false
      t.references :category,           null: false
      t.string :brand
      t.references :condition,          null: false
      t.references :postage,            null: false
      t.references :shipping_area,      null: false
      t.references :preparation_period, null: false
      t.integer :price,                 null: false
      t.references :user,               null: false
      t.timestamps
    end
  end
end

#, foreign_key: true
#, foreign_key: { to_table: :prefectures }