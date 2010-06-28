class Name < ActiveRecord::Base
  include ShortUrl
  validates_uniqueness_of :name
  belongs_to :user
  has_many :likes
  has_many :dislikes

  SORT_OPTIONS = [
    ["new", "created_at DESC"],
    ["likes", "likes_count DESC"],
    ["alpha", "name"]
  ]
end
