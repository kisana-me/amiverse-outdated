class CreateAccountFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :account_feeds do |t|
      t.references :account, null: false, foreign_key: true
      t.references :feed, null: false, foreign_key: true
      t.timestamps
    end
  end
end
