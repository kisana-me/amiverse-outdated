class CreatePolymorphicLimits < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_limits do |t|
      t.references :target, null: false, polymorphic: true
      t.references :limit, null: false, foreign_key: true
      t.timestamps
    end
  end
end
