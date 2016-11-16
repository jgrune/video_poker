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
    self.hand_rank = Poker::Hand.new(eval).rank
    self.save!
  end

  def deal_hand
    @card_array = Card.order("RANDOM()").first(5)
    @card_array.each do |card|
      CardsInHand.create!(card: card, hand: self)
    end
  end

  def update_hand card_ids

    # create new cards (length of card.id array) whos ids are not in the temp array

    used = self.cards.map {|card| card.id}
    card_ids = card_ids.map {|id| id.to_i}
    deck = Card.all.map {|card| card.id}

    replace_ids = used-card_ids

    new_ids = (deck - used).sample(5 - card_ids.length)
    new_cards = new_ids.map {|id| Card.find(id)}

    # add new cards to hand
    new_cards.each do |card|
      CardsInHand.create!(card: card, hand: self)
    end

    # delete replaced cards from hand
    replace_ids.each do |id|
      replaced_card = CardsInHand.where(hand: self).find_by(card_id: id)
      replaced_card.destroy
    end

  end
end
