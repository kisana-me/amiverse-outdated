class CreateServerProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :server_properties do |t|
      t.string :aid, null: false
      # server info
      t.string :server_name, null: false, default: 'Amiverse'
      t.string :server_version, null: false, default: 'v.0.0.5'
      t.text :server_description, null: false, default: ''
      # features
      t.boolean :open_registrations, null: false, default: false
      t.json :languages, null: false, default: ['ja']
      t.string :theme_color, null: false, default: '#22ff22'
      t.json :urls, null: false, default: ['https://amiverse.net/']
      t.json :others, null: false, default: []
      # maintainer
      t.string :maintainer_name, null: false, default: 'Amiverse Net'
      t.string :maintainer_email, null: false, default: 'amiverse@amiverse.net'
      # total numbers
      t.bigint :accounts, null: false, default: 0
      t.bigint :items, null: false, default: 0
      t.bigint :images, null: false, default: 0
      t.bigint :audios, null: false, default: 0
      t.bigint :videos, null: false, default: 0
      t.bigint :emojis, null: false, default: 0
      t.bigint :reactions, null: false, default: 0
      # other
      t.json :meta, null: false, default: {}
      t.datetime :published_at
      # activitypub
      t.boolean :activitypub, null: false, default: false
      t.json :ap_meta, null: false, default: {}
      # trend
      t.integer :trend_interval, null: false, default: 30
      t.integer :trend_samplings, null: false, default: 200
      t.integer :trend_search_words, null: false, default: 100
      # ga4
      t.boolean :ga4, null: false, default: true
      t.string :ga4_id, null: false, default: 'VP5CN519Q8'
      t.timestamps
    end
  end
end
