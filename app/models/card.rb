class Card < ActiveRecord::Base
  belongs_to :cards_in_hand, optional: true
  has_many :hands, through: :cards_in_hand

end
