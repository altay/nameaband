class User < ActiveRecord::Base
  acts_as_authentic{|c|
    #c.validates_length_of_email_field_options(:minimum=>nil)
    #c.validate_login_field(false)
  }
#  validates_uniqueness_of :login
  has_many :names
  has_many :likes
  has_many :dislikes
  has_many :liked_names, :through=>:likes, :source=>:name
  has_many :disliked_names, :through=>:dislikes, :source=>:name
  after_create{|new_user|
    if !new_user.login.empty?
      new_user.anonymous=false
      new_user.save!
    end
  }

  def judged_names
    return self.liked_names+self.disliked_names
  end

  def judged_name_ids
    return (self.liked_names+self.disliked_names).map(&:id)
  end

  def last_judgement
    last_like = self.likes.find(:first, :order=>"id DESC")
    last_dislike = self.dislikes.find(:first, :order=>"id DESC")
    return nil if (last_like.nil? && last_dislike.nil?)
    return last_like if last_dislike.nil?
    return last_dislike if last_like.nil?
    return (last_like.created_at>last_dislike.created_at ? last_like : last_dislike)
  end

end
