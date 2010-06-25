class Name < ActiveRecord::Base
  include ShortUrl
  validates_uniqueness_of :name
  belongs_to :user
  has_many :likes

  SORT_OPTIONS = [
    ["new", "created_at DESC"],
    ["likes", "likes_count DESC"],
    ["alpha", "name"]
  ]
end
