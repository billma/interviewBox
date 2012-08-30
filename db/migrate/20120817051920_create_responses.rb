class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :archiveId
      t.string :comment
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
