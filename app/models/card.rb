class Card < ActiveRecord::Base
  belongs_to :cards_in_hand, optional: true
  has_many :hands, through: :cards_in_hand

  def self.reset_deck
    Card.all.each do |card|
      card.dealt = false
    end
  end
end
