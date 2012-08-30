class Question < ActiveRecord::Base
  attr_accessible :archiveId, :description, :up_vote, :user_id,:title,:questionType, :image
  belongs_to :user
  has_many :response
  default_scope :order=> "created_at DESC"
end
