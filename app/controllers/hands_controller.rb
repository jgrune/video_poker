class HandsController < ApplicationController

  def index
    @hands = Hand.all
  end

  def new
    @hand = Hand.new
  end

  def show
    @hand = Hand.find(params[:id])

    @handrank = @hand.get_poker_hand_rank
    @current_user.updatebalance(@handrank, session[:bet])
  end

  def create
    session[:bet] = params[:bet]
    # render plain: session.inspect
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

end
