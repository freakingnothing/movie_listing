class List < ApplicationRecord
  belongs_to :user
  has_many :listings, dependent: :destroy
  has_many :movies, through: :listings

  validates :title, presence: true
end
