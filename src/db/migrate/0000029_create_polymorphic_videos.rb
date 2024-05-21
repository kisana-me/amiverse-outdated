class CreatePolymorphicVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :polymorphic_videos do |t|
      t.references :target, null: false, polymorphic: true
      t.references :video, null: false, foreign_key: true
      t.timestamps
    end
  end
end
