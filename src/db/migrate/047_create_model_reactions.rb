class CreateModelReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :model_reactions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :emoji, null: false, foreign_key: true
      t.string :model, null: false, default: ''
      t.string :aid, null: false, default: ''
      t.string :effect_type, null: false, default: ''
      t.string :kind, null: false, default: ''
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
