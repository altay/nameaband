class User < ActiveRecord::Base
  acts_as_authentic
  validates_uniqueness_of :login
  has_many :names
  has_many :likes
  has_many :dislikes
  has_many :liked_names, :through=>:likes, :source=>:name
  has_many :disliked_names, :through=>:dislikes, :source=>:name
end
