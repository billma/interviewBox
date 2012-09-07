class Question < ActiveRecord::Base
  attr_accessible :archiveId, :description, :up_vote, :user_id,:title,:questionType, :image,:videoId,:downloadUrl
  belongs_to :user
  has_many :vote,:dependent => :destroy
  has_many :response
  default_scope :order=> "created_at DESC"
end
