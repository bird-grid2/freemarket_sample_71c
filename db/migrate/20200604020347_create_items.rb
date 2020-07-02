class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name, null: false
      t.text       :description, null: false
      t.string     :brand, null: true
      t.integer    :price, null: false
      t.references :seller, foreign_key: {to_table: :users}
      t.references :buyer, foreign_key: {to_table: :users}
      t.references :condition, null: false
      t.references :postage, null: false
      t.references :prefecture, null: false
      t.references :preparation_period, null: false
      t.references :shipping_method, null: false
      t.references :category, null: false
      t.timestamps
    end
  end
end