class CreatePolymorphicReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_reactions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :emoji, null: false, polymorphic: true
      t.references :target, null: false, polymorphic: true
      t.boolean :effect, null: false, default: false
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
