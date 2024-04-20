class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :name_id, null: false
      # fediverse
      ## activitypub
      t.boolean :foreigner, null: false, default: false
      t.boolean :activitypub, null: false, default: false
      t.string :activitypub_url, null: false, default: ''
      t.string :activitypub_id, null: false, default: ''
      t.datetime :ap_last_fetched_at
      t.json :ap_meta, null: false, default: []
      t.text :public_key, null: false, default: ''
      t.text :private_key, null: false, default: ''
      # profile
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      t.string :online_status, null: false, default: 'offline'
      t.datetime :last_online
      t.string :online_visibility, null: false, default: 'public'
      t.text :description, null: false, default: ''
      t.json :additional_informations, null: false, default: {}
      t.string :location, null: false, default: ''
      t.datetime :birthday
      t.string :birthyear_visibility, null: false, default: 'public'
      t.string :birthmonthday_visibility, null: false, default: 'public'
      t.json :pinned_items, null: false, default: []
      t.json :languages, null: false, default: []
      t.string :followers_visibility, null: false, default: 'public'
      t.string :following_visibility, null: false, default: 'public'
      t.string :reactions_visibility, null: false, default: 'public'
      # setting
      t.boolean :discoverable, null: false, default: true
      t.boolean :auto_accept_follow, null: false, default: true
      t.boolean :no_crawle, null: false, default: false
      t.boolean :prevent_ai_learning, null: false, default: false
      t.json :mutes, null: false, default: {}
      t.string :email, null: false, default: ''
      t.boolean :email_verified, null: false, default: false
      t.boolean :use_login_id, null: false, default: false
      t.string :login_id, null: false, default: ''
      t.string :usage_type, null: false, default: ''
      t.json :defaults, null: false, default: {}#itemなど投稿時のデフォ
      t.json :settings, null: false, default: {}
      # cache
      t.string :icon_id, null: false, default: ''# なくす
      t.string :banner_id, null: false, default: ''# なくす
      t.bigint :followers_counter, null: false, default: 0
      t.bigint :following_counter, null: false, default: 0
      t.bigint :items_counter, null: false, default: 0
      t.bigint :reactions_counter, null: false, default: 0
      t.json :badges, null: false, default: []
      t.json :roles, null: false, default: []
      t.json :permissions, null: false, default: []
      t.json :checker, null: false, default: []
      t.json :cache, null: false, default: []
      # flag
      t.boolean :administrator, null: false, default: false
      t.boolean :moderator, null: false, default: false
      t.boolean :activated, null: false, default: false
      t.boolean :hibernation, null: false, default: false# 冬眠
      t.boolean :locked, null: false, default: false# 解除待ち
      t.boolean :silenced, null: false, default: false# 長い間使用されていない
      t.boolean :suspended, null: false, default: false# 不具合など一時的な処置
      t.boolean :frozen, null: false, default: false# 違反などで利用できなくする処置
      t.boolean :suggestion_ban, null: false, default: false
      # property
      t.json :achievements, null: false, default: []
      t.json :features, null: false, default: [] # 活動内容のtopic
      t.json :curious, null: false, default: [] # 興味のあるtopic
      t.json :meta, null: false, default: []
      t.integer :score, null: false, default: 0
      # other
      t.text :moderation_note, null: false, default: ''
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
