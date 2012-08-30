class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :archiveId
      t.text :description
      t.integer :user_id
      t.integer :up_vote
      t.string :questionType

      t.timestamps
    end
  end
end
