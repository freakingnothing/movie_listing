class Listing < ApplicationRecord
  include AASM

  aasm do
    state :active, initial: true
    state :completed

    event :complete do
      transitions from: :active, to: :completed
    end

    event :activate do
      transitions from: :completed, to: :active
    end
  end

  belongs_to :list
  belongs_to :movie
end
