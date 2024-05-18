class CreatePolymorphicAudios < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_audios do |t|
      t.references :target, null: false, polymorphic: true
      t.references :audio, null: false, foreign_key: true
      t.timestamps
    end
  end
end
