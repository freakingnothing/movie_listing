class Movie < ApplicationRecord
  has_many :listings
  has_many :lists, through: :listings
end
