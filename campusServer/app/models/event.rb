class Event < ActiveRecord::Base
  has_and_belongs_to_many :user
  has_and_belongs_to_many :group
end
