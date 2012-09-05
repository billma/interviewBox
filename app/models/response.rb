class Response < ActiveRecord::Base
  attr_accessible :archiveId, :comment, :question_id, :user_id,:image
  belongs_to :user
  belongs_to :question
  has_many :comment
  default_scope :order=> "created_at DESC"
end
