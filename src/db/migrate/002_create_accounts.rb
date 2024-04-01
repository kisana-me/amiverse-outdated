class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :name_id, null: false
      # fediverse
      t.boolean :foreigner, null: false, default: false
      t.boolean :activitypub, null: false, default: false
      t.string :activitypub_id, null: false, default: ''
      t.text :public_key, null: false, default: ''
      t.text :private_key, null: false, default: ''
      t.boolean :atprotocol, null: false, default: false
      t.string :atprotocol_id, null: false, default: ''
      # profile
      t.boolean :online, null: false, default: true
      t.datetime :last_online
      t.boolean :invisible_online, null: false, default: false
      t.boolean :discoverable, null: false, default: true
      t.boolean :manually_approves_followers, null: false, default: false
      t.text :summary, null: false, default: ''
      t.string :location, null: false, default: ''
      t.datetime :birthday
      t.boolean :invisible_birthday, null: false, default: false
      t.json :pinned_items, null: false, default: []
      t.json :languages, null: false, default: []
      t.json :achievements, null: false, default: []
      # cache
      t.string :icon_id, null: false, default: ''
      t.string :banner_id, null: false, default: ''
      t.bigint :followers_counter, null: false, default: 0
      t.bigint :following_counter, null: false, default: 0
      t.bigint :items_counter, null: false, default: 0
      t.bigint :reactions_counter, null: false, default: 0
      t.json :cache, null: false, default: []
      # property
      t.string :email, null: false, default: ''
      t.json :defaults, null: false, default: []
      t.json :settings, null: false, default: []
      t.json :meta, null: false, default: []
      t.string :kind, null: false, default: ''
      t.json :roles, null: false, default: []
      t.integer :score, null: false, default: 0
      t.boolean :activated, null: false, default: false
      t.boolean :locked, null: false, default: false
      t.boolean :silenced, null: false, default: false
      t.boolean :suspended, null: false, default: false
      t.boolean :frozen, null: false, default: false
      t.bigint :storage_size, null: false, default: 0
      t.bigint :storage_max_size, null: false, default: 1000000000
      t.string :password_digest
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :accounts, [:aid, :name_id, :activitypub_id], unique: true
  end
end
