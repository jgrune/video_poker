class HandsController < ApplicationController
  def index
    @hands = Hand.all
  end

  def show
    @hand = Hand.find(params[:id])
  end


  def new
    hand = Hand.create
    card_array = Card.order("RANDOM()").first(5)
    card_array.each do |card|
      card.hand_id = hand[:id]
      card.img = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Bordered_#{card.suit[0]}_#{card.value}.svg/88px-Bordered_#{card.suit[0]}_#{card.value}.svg.png"
      card.dealt = true
      card.save
    end
    @lasthand = Hand.last
    eval @lasthand
    redirect_to @lasthand
  end

# do i even need a create function??
  def create
    redirect_to hands_index_path
  end

  def delete
  end

  def rank
  end

private

  def eval hand
    suits = hand.cards.map{|card| card.suit}
    values = hand.cards.map{|card| card.value}
  end
end
