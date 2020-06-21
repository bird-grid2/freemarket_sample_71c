class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name,                    null: false
      t.text    :desctiption,             null: false
      t.string  :brand
      t.integer :price,                   null: false
      t.references :seller, foreign_key: {to_table: :users}, null: false
      t.references :buyer, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
