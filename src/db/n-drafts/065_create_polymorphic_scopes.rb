class CreatePolymorphicScopes < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_scopes do |t|
      t.references :target, null: false, polymorphic: true
      t.references :scope, null: false, foreign_key: true
      t.timestamps
    end
  end
end
