class CreateInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :inquiries do |t|
      t.string :aid, null: false
      t.string :kind, null: false, default: ''
      t.string :title, null: false, default: ''
      t.text :content, null: false, default: ''
      t.string :contact, null: false, default: ''
      t.boolean :solved, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :inquiries, [:aid], unique: true
  end
end
