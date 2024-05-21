class CreatePolymorphicBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_banners do |t|
      t.references :target, null: false, polymorphic: true
      t.references :banner, null: false, foreign_key: true
      t.timestamps
    end
  end
end
