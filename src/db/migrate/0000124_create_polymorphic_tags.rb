class CreatePolymorphicTags < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_tags do |t|
      t.references :target, null: false, polymorphic: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
