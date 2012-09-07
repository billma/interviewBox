class AddDownloadUrlToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :downloadUrl, :string
  end
end
