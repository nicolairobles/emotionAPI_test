class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.references :video, index: true, foreign_key: true
      t.string :video_timestamp
      t.decimal :anger
      t.decimal :contempt
      t.decimal :disgust
      t.decimal :fear
      t.decimal :happiness
      t.decimal :neutral
      t.decimal :sadness
      t.decimal :surprise

      t.timestamps null: false
    end
  end
end
