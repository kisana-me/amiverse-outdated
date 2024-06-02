class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.string :aid, null: false
      t.integer :feed_type, limit: 1, null: false, default: 0 # アカウント、共通、言語共通、、
      t.integer :usage_type, limit: 1, null: false, default: 0 # アカウントならおすすめかフォロー中かなど、、
      t.json :data, null: false, default: []
      t.timestamps
    end
    add_index :feeds, [:aid], unique: true
  end
end
