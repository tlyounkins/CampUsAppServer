class Group < ActiveRecord::Base
  has_and_belongs_to_many :user
  has_many :group_micropost, dependent: :destroy
  has_many :group_events
end
