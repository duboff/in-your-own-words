class Skill < ActiveRecord::Base
  searchkick
  has_and_belongs_to_many :users
end
