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
    num = 1
    @card_array.each do |card|
      CardsInHand.create!(card: card, hand: self, position: num)
      num += 1
    end
  end

  def update_hand card_ids
    # get ids of cards you want to replace
    used = self.cards.map {|card| card.id}
    card_ids = card_ids.map {|id| id.to_i}
    replace_ids = used - card_ids

    # remember those replacement card positions
    replace_ids_pos = replace_ids.map{|id|
      card = CardsInHand.find_by(hand: self, card_id: id)
      card.position
     }

    # get ids of new cards (ensuring you don't select cards from original hand)
    deck = Card.all.map {|card| card.id}
    new_ids = (deck - used).sample(replace_ids.length)

    # add new cards to hand and assign appropriate positions
    num = 0
    new_ids.each do |id|
      CardsInHand.create!(card_id: id, hand: self, position: replace_ids_pos[num])
      num += 1
    end

    # delete replaced cards from hand
    replace_ids.each do |id|
      replaced_card = CardsInHand.where(hand: self).find_by(card_id: id)
      replaced_card.destroy
    end

  end
end
