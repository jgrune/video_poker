class HandsController < ApplicationController

  def index
    @hands = Hand.all
  end

  def show
    @hand = Hand.find(params[:id])
    eval_hand = Poker::Hand.new(eval @hand.cards)

    # puts "*" * 50
    # puts hand1.rank
    @test = eval_hand.rank
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

    redirect_to edit_hand_path(@lasthand)
  end

  def edit
    @hand = Hand.find(params[:id])
  end

  def update
    # render plain: params.inspect
    if params[:card_ids]
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

end
