class CreatePolymorphicIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_icons do |t|
      t.references :target, null: false, polymorphic: true
      t.references :icon, null: false, foreign_key: true
      t.timestamps
    end
  end
end
