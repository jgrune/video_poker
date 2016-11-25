# this class name should be cardinhand. Rails will pluralize this weirdly. but cardsinhand strikes me as a different thing. And it is a single card in hand. Better might be playerCard or playedCard. Or <insert adjective here>Card.
class CardsInHand < ApplicationRecord
  belongs_to :card
  belongs_to :hand
end
