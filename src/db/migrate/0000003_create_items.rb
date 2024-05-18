class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.integer :rendering_type, limit: 1, null: false, default: 0
      t.text :content, null: false, default: ''
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      t.integer :score, null: false, default: 0
      # 制限
      t.boolean :scoping, null: false, default: false
      t.integer :reply_limiting, limit: 1, null: false, default: 0
      t.integer :diffution_limiting, limit: 1, null: false, default: 0
      t.integer :quote_limiting, limit: 1, null: false, default: 0
      t.integer :reaction_limiting, limit: 1, null: false, default: 0
      # cache
      t.integer :viewed_counter, null: false, default: 0
      t.integer :replied_counter, null: false, default: 0
      t.integer :diffused_counter, null: false, default: 0
      t.integer :quoted_counter, null: false, default: 0
      t.integer :reacted_counter, null: false, default: 0
      t.json :cache, null: false, default: {}
      # other
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: {}
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      # fediverse
      t.boolean :foreign, null: false, default: false
      ## activitypub
      t.boolean :activitypub, null: false, default: false
      t.boolean :ap_scoping, null: false, default: false # apから見れる
      t.string :ap_uri, null: false, default: ''
      t.string :ap_url, null: false, default: ''
      t.datetime :ap_last_fetched_at
      t.json :ap_meta, null: false, default: {}
      t.timestamps
    end
    add_index :items, [:aid], unique: true
  end
end
