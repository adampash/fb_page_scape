require 'active_record'

class Post < ActiveRecord::Base
  validates_uniqueness_of :fb_id
  has_many :comments

end

