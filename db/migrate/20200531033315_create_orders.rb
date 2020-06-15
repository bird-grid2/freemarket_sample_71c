class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user_id, type: :bigint, null: false, foreign_key: true
      t.references :item, type: :bigint, null: false, foreign_key: true
      t.timestamps
    end
  end
end
