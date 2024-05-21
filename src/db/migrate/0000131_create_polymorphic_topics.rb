class CreatePolymorphicTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_topics do |t|
      t.references :target, null: false, polymorphic: true
      t.references :topic, null: false, foreign_key: true
      t.timestamps
    end
  end
end
