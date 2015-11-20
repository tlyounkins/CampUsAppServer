class Group < ActiveRecord::Base
  has_and_belongs_to_many :user
  has_many :microposts
  has_many :events
end
