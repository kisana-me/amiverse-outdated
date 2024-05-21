class CreateItemListRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :item_list_relations do |t|
      t.references :item, null: false, foreign_key: true
      t.references :item_list, null: false, foreign_key: true
      t.timestamps
    end
  end
end
