class AddDownloadUrlToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :downloadUrl, :string
  end
end
