class CreateItemCanvases < ActiveRecord::Migration[7.0]
  def change
    create_table :item_canvases do |t|
      t.references :item, null: false, foreign_key: true
      t.references :canvas, null: false, foreign_key: true
      t.timestamps
    end
  end
end
