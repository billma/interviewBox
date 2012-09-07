class Vote < ActiveRecord::Base
  attr_accessible :question_id, :response_id, :user_id
  belongs_to :question
  belongs_to :response
end
