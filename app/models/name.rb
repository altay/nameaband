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

  def percent_liked
    return ((self.likes_count.to_f/(self.likes_count+self.dislikes_count).to_f)*100.0)
  end

end
