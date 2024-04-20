class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :rendering_type, null: false, default: ''
      t.text :content, null: false, default: ''
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      t.integer :score, null: false, default: 0
      t.boolean :foreign, null: false, default: false
      t.string :original_url, null: false, default: ''
      t.boolean :federation, null: false, default: false # 外部公開しなければ制限適用可
      # 制限
      t.boolean :scope, null: false, default: false # 見れる範囲
      t.boolean :reply_limit, null: false, default: false
      t.boolean :diffution_limit, null: false, default: false
      t.boolean :quote_limit, null: false, default: false
      t.boolean :reaction_limit, null: false, default: false
      # cache
      t.integer :reply_counter, null: false, default: 0
      t.integer :diffution_counter, null: false, default: 0
      t.integer :quote_counter, null: false, default: 0
      t.integer :reaction_counter, null: false, default: 0
      # other
      t.string :usage_type, null: false, default: ''
      t.boolean :ai_generated, null: false, default: false
      t.boolean :private, null: false, default: false
      t.boolean :draft, null: false, default: false
      t.boolean :scheduled, null: false, default: false
      t.datetime :scheduled_at
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :items, [:aid], unique: true
  end
end
