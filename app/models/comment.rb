class Comment < ActiveRecord::Base
  attr_accessible :content, :response_id, :user_id
  belongs_to :user
  belongs_to :response
end
