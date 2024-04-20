class CreateModelAudios < ActiveRecord::Migration[7.0]
  def change
    create_table :model_audios do |t|
      t.string :model, null: false, default: ''
      t.string :aid, null: false, default: ''
      t.references :audio, null: false, foreign_key: true
      t.timestamps
    end
  end
end
