class CreateAccountBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :account_banners do |t|
      t.references :account, null: false, foreign_key: true
      t.references :banner, null: false, foreign_key: true
      t.timestamps
    end
  end
end
