class HandsController < ApplicationController
  before_action :find_hand, only: [:show, :edit, :update]

  def find_hand
    @hand = Hand.find(params[:id])
  end

  def index
    @hands = Hand.all
  end

  def new
    @hand = Hand.new
  end

  def show
  end

  def create
    session[:bet] = params[:bet]
    # render plain: session.inspect
    @hand = Hand.create!
    @hand.user = @current_user
    @hand.save
    @hand.deal_hand

    redirect_to edit_hand_path(Hand.last)
  end

  def edit
  end

  def update
    if params[:card_ids]
      @hand.update_hand params[:card_ids]
    end

    Card.reset_deck

    @hand.hand_rank = @hand.get_poker_hand_rank
    @hand.save

    @current_user.updatebalance(@handrank, session[:bet])

    redirect_to @hand
  end


  def delete
  end

end
