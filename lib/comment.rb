require 'active_record'

class Comment < ActiveRecord::Base
  validates_uniqueness_of :fb_id
  belongs_to :post

end
