class CreatePolymorphicFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_feeds do |t|
      t.references :target, null: false, polymorphic: true
      t.references :feed, null: false, foreign_key: true
      t.timestamps
    end
  end
end
