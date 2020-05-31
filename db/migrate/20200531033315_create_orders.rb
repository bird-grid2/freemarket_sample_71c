class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.bigint :user_id, foreign_key: true
      #t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
