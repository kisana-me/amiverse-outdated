class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      # profile
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :name_id, null: false
      ## sensitive
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      ## online
      t.integer :online_status, limit: 1, null: false, default: 0
      t.integer :online_visibility, limit: 1, null: false, default: 0
      t.datetime :last_online
      ## info
      t.integer :layout_type, limit: 1, null: false, default: 0
      t.text :description, null: false, default: ''
      t.integer :render_type, limit: 1, null: false, default: 0
      t.json :additional_informations, null: false, default: []
      t.string :location, null: false, default: ''
      t.date :birth
      t.integer :birth_year_visibility, limit: 1, null: false, default: 0
      t.integer :birth_month_visibility, limit: 1, null: false, default: 0
      t.integer :birth_day_visibility, limit: 1, null: false, default: 0
      t.json :pinned_items, null: false, default: []
      t.integer :language, limit: 1, null: false, default: 0
      ## data
      t.integer :followers_visibility, limit: 1, null: false, default: 0
      t.integer :following_visibility, limit: 1, null: false, default: 0
      t.integer :reactions_visibility, limit: 1, null: false, default: 0
      # setting
      t.boolean :discoverable, null: false, default: true
      t.boolean :auto_accept_follow, null: false, default: true
      t.string :email, null: false, default: ''
      t.boolean :email_verified, null: false, default: false
      t.string :login_id, null: false, default: ''
      t.boolean :use_login_id, null: false, default: false
      t.integer :usage_type, limit: 1, null: false, default: 0
      t.json :defaults, null: false, default: []#itemなど投稿時のデフォ
      t.json :settings, null: false, default: []#frontのレイアウトなどの設定群
      # cache
      t.string :icon_key, null: false, default: ''
      t.string :banner_key, null: false, default: ''
      t.bigint :followers_counter, null: false, default: 0
      t.bigint :following_counter, null: false, default: 0
      t.bigint :items_counter, null: false, default: 0
      t.bigint :reactions_counter, null: false, default: 0
      t.bigint :reacted_counter, null: false, default: 0
      t.bigint :viewed_counter, null: false, default: 0
      #t.json :mutes, null: false, default: {}
      #t.json :badges, null: false, default: []# 表示のみの称号
      #t.json :roles, null: false, default: []# 権限あり
      #t.json :permissions, null: false, default: []# 一日の投稿数など一般的な権限
      #t.json :achievements, null: false, default: []
      t.json :checker, null: false, default: {}# 単位時間当たりの使用量を計測
      t.json :cache, null: false, default: {}
      # flag
      #t.boolean :activated, null: false, default: false 1
      #t.boolean :hibernated, null: false, default: false# アカウントを無かったことにする 2
      #t.boolean :locked, null: false, default: false# パスワード間違いすぎなどで解除待ち 3
      #t.boolean :silenced, null: false, default: false# 長い間使用されていない 4
      #t.boolean :suspended, null: false, default: false# 不具合など一時的な処置 5
      #t.boolean :frozen, null: false, default: false# 違反などで利用できなくする処置 6
      t.boolean :shadow_banned, null: false, default: false# 公然の目に表示されにくい
      t.integer :status, limit: 1, null: false, default: 0
      # property
      #t.json :account_topics, null: false, default: [] # 活動内容のtopic
      #t.json :interest_topics, null: false, default: [] # 興味のあるtopic
      t.json :meta, null: false, default: {}
      t.integer :score, null: false, default: 0
      # other
      t.bigint :used_storage_size, null: false, default: 0
      t.bigint :max_storage_size, null: false, default: 1000000000
      t.string :password_digest
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      # fediverse
      t.boolean :foreigner, null: false, default: false
      ## activitypub
      t.boolean :activitypub, null: false, default: false
      t.boolean :ap_status, null: false, default: false # apから見れる
      t.string :ap_uri, null: false, default: ''
      t.string :ap_url, null: false, default: ''
      t.datetime :ap_last_fetched_at
      t.json :ap_meta, null: false, default: {}
      t.text :ap_public_key, null: false, default: ''
      t.text :ap_private_key, null: false, default: ''
      t.timestamps
    end
    add_index :accounts, [:aid, :name_id, :ap_uri], unique: true
  end
end
