class CardsInHand < ApplicationRecord
  belongs_to :card
  belongs_to :hand
end
