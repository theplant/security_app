class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected

  validates_presence_of :comment, :cat

  belongs_to :user
end
