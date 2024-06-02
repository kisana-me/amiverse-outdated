class CreateTrendWords < ActiveRecord::Migration[7.0]
  def change
    create_table :trend_words do |t|
      t.references :trend, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.timestamps
    end
  end
end
