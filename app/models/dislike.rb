class Dislike < ActiveRecord::Base
  belongs_to :name
  belongs_to :user
end
