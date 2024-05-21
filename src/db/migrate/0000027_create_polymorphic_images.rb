class CreatePolymorphicImages < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_images do |t|
      t.references :target, null: false, polymorphic: true
      t.references :image, null: false, foreign_key: true
      t.timestamps
    end
  end
end
