class Deck
  attr_reader :cards

  def initialize
    @cards = Card.all.to_a
    shuffle
  end

  def shuffle
    @cards = @cards.shuffle!
  end

  def deal num
    dealt_cards = []
    dealt_cards << @cards.pop(num)
  end

end
