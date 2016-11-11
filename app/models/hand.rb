class Hand < ApplicationRecord
  has_many :cards
  belongs_to :user, optional: true
end
