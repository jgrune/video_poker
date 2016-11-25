class Hand < ApplicationRecord
  has_many :cards_in_hand
  has_many :cards, through: :cards_in_hand
  belongs_to :user, optional: true

  def eval
    # no need to use instance variable here. Unless your trying to make it accessible on the instance, which it doesn't look like
    # additionally, I recommend using a hash here instead of nested conditionals something like this:
    # hand_mapping = {
    #   14: "A",
    #   13: "K",
    #   ...
    # }
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

    @card_array.each_with_index{|card, i|
      CardsInHand.create!(card: card, hand: self, position: i + 1)
    }
  end

#: +1:
  def update_hand card_ids
    # get ids of cards you want to replace
    used_card_ids = self.cards.map {|card| card.id}
    card_ids = card_ids.map {|id| id.to_i}
    replace_ids = used_card_ids - card_ids

    # get ids of new cards (ensuring you don't select cards from original hand)
    all_card_ids = Card.all.map {|card| card.id}
    new_ids = (all_card_ids - used_card_ids).sample(replace_ids.length)

    # update old cards with new cards
    replace_ids.each_with_index {|id, i|
      card = CardsInHand.find_by(hand: self, card_id: id)
      card.update!(card_id: new_ids[i])
     }

  end
end
