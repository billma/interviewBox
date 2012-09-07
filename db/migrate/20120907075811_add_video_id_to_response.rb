class AddVideoIdToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :videoId, :string
  end
end
