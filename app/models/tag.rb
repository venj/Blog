class Tag < ActiveRecord::Base
  has_many :posts, :through => :taggings
  has_many :taggings
end
