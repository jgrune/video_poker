class HandsController < ApplicationController

  def index
    @hands = Hand.all
  end

  def show
    @hand = Hand.find(params[:id])
  end

  def create
    hand = Hand.create!
    @card_array = Card.order("RANDOM()").first(5)
    @card_array.each do |card|
      card.hand_id = hand[:id]
      card.img = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Bordered_#{card.suit[0]}_#{card.value}.svg/88px-Bordered_#{card.suit[0]}_#{card.value}.svg.png"
      card.dealt = true
      card.save
    end
    @lasthand = Hand.last

# how do you use a gem like this?

    redirect_to @lasthand
  end

  def edit
    @hand = Hand.find(params[:id])
  end

  def update
    # render plain: params.inspect
    card_array = params[:card_ids].map {|id|
      Card.find(id)
    }
    card_array.each do |card|
      card.hand_id = ""
      card.save
    end

    new_cards = Card.order("RANDOM()").first(card_array.length)

    new_cards.each do |card|
      card.hand_id = params[:id]
      card.img = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Bordered_#{card.suit[0]}_#{card.value}.svg/88px-Bordered_#{card.suit[0]}_#{card.value}.svg.png"
      card.dealt = true
      card.save
    end

    last_hand = Hand.find(params[:id])
    redirect_to last_hand
  end


  def delete
  end

private
  def eval cards
    @eval_hand = cards.map {|card|
      if card.value == 14
        "A#{card.suit[0].upcase}"
      elsif card.value == 13
        "K#{card.suit[0].upcase}"
      elsif card.value == 12
        "Q#{card.suit[0].upcase}"
      elsif card.value == 11
        "J#{card.suit[0].upcase}"
      elsif card.value == 10
        "T#{card.suit[0].upcase}"
      else
        "#{card.value}#{card.suit[0].upcase}"
      end
    }
  end

end
