class CreateShipingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shiping_addresses do |t|
      t.string     :family_name, null: false
      t.string     :first_name, null: false
      t.string     :family_name_kana, null: false
      t.string     :first_name_kana, null: false
      t.integer    :post_code, null: false
      t.string     :prefecture, null: false
      t.string     :city, null: false
      t.string     :block, null: false
      t.string     :building
      t.string    :phone_number 
      t.references :user, null: false, foreign_key: true
      t.timestamps 
    end
  end
end