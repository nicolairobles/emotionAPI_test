class AddEmailToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :email, :string
  end
end
