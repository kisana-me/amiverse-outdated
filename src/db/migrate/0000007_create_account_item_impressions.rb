class CreateAccountItemImpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_item_impressions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :activity_type, limit: 1, null: false, default: 0
      t.timestamps
    end
  end
end
