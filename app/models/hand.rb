class Hand < ApplicationRecord
  has_many :cards
  belongs_to :user, optional: true

  def eval
    @eval_hand = self.cards.map {|card|
      if card.value == 14
        "A#{card.suit[0]}"
      elsif card.value == 13
        "K#{card.suit[0]}"
      elsif card.value == 12
        "Q#{card.suit[0]}"
      elsif card.value == 11
        "J#{card.suit[0]}"
      elsif card.value == 10
        "T#{card.suit[0]}"
      else
        "#{card.value}#{card.suit[0]}"
      end
    }
    @eval_hand.join(" ")
  end

  def get_poker_hand_rank
    Poker::Hand.new(eval).rank
  end

end
