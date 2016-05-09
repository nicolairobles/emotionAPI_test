class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :time_length

      t.timestamps null: false
    end
  end
end
