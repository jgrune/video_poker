class Hand < ApplicationRecord
  has_many :cards_in_hand
  has_many :cards, through: :cards_in_hand
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

  def deal_hand
    @card_array = Card.order("RANDOM()").first(5)
    @card_array.each do |card|
      CardsInHand.create!(card: card, hand: self)
      card.dealt = true
      card.save
    end
  end

  def update_hand card_ids
    new_cards = Card.where(dealt: "false").order("RANDOM()").first(card_ids.length)

    card_ids.each do |id|
      replaced_card = CardsInHand.where(hand: self).find_by(card_id: id.to_i)
      replaced_card.destroy
    end

    new_cards.each do |card|
      CardsInHand.create!(card: card, hand: self)
      card.save
    end
  end
end
