class User < ActiveRecord::Base
  attr_protected
  validates_presence_of :username, :password
  validates_uniqueness_of :username

  has_many :comments
end
