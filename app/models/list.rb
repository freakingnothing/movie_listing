class List < ApplicationRecord
  belongs_to :user
  has_many :listings
  has_many :movies, through: :listings
end
