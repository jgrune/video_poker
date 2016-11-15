class User < ApplicationRecord
  has_many :hands

  def calc_winnings handrank, bet
    case handrank
      when "Royal Flush"
        @winnings = bet.to_i * 500
      when "Straight Flush"
        @winnings = bet.to_i * 200
      when "Four of a Kind"
        @winnings = bet.to_i * 100
      when "Full House"
        @winnings = bet.to_i * 50
      when "Flush"
        @winnings = bet.to_i * 30
      when "Straight"
        @winnings = bet.to_i * 20
      when "Three of a Kind"
        @winnings = bet.to_i * 8
      when "Two Pair"
        @winnings = bet.to_i * 3
      when "Pair"
        @winnings = bet.to_i * 1
      else
        @winnings = bet.to_i * -1
    end
      @winnings
  end

  def update_balance winnings
    self.dollars += winnings
    self.save
  end

  def reload_balance
    self.dollars = 100
    self.save
  end

end
