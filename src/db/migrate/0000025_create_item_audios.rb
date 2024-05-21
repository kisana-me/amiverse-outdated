class CreateItemAudios < ActiveRecord::Migration[7.0]
  def change
    create_table :item_audios do |t|
      t.references :item, null: false, foreign_key: true
      t.references :audio, null: false, foreign_key: true
      t.timestamps
    end
  end
end
