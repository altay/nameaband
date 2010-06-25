class User < ActiveRecord::Base
  acts_as_authentic
  validates_uniqueness_of :login
  has_many :names
  has_many :likes
  has_many :liked_names, :through=>:likes, :source=>:name
end
