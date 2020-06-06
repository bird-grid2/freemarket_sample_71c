class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tentatives do |t|
      t.string :nickname,         null: false
      t.string :email,            null: false, unique: true
      t.string :password_digest,  null: false
      t.string :family_name,      null: false
      t.string :first_name,       null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana,  null: false
      t.date   :birthday,         null: false
      t.timestamps
    end
  end
end
