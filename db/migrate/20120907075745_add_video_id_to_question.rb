class AddVideoIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :videoId, :string
  end
end
