class Deck
  attr_reader :cards

  def initialize
    @cards = Card.all.to_a
    shuffle
  end

  def shuffle
    @cards = @cards.shuffle!
  end

  def deal num, hand
    dealt_cards = @cards.pop(num)

    dealt_cards.each do |card|
      CardsInHand.create!(card: card, hand: hand)
    end

  end

end
