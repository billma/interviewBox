class User < ActiveRecord::Base
  attr_accessible :email, :name, :uid
  has_many :response, :dependent => :destroy
  has_many :question, :dependent => :destroy
end
