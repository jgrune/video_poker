class HandsController < ApplicationController
  before_action :find_hand, only: [:show, :edit, :update]
  # make this a private method
  def find_hand
    @hand = Hand.find(params[:id])
  end

  def index
    @hands = @current_user.hands
  end

  def new
    @hand = Hand.new
  end

  def show
  end

  def create
    session[:bet] = params[:bet]
    # could this be refactored like this: @hand = @current_user.hands.create!
    @hand = Hand.create!
    @hand.user = @current_user
    @hand.save
    @hand.deal_hand

    redirect_to edit_hand_path(Hand.last)
  end

  def edit
  end

  def update
    ## there's a bug in this method, if you don't select any of the cards too hold, it doesn't replace any of the cards. I think this is happening because of this if conditional
    if params[:card_ids]
      @hand.update_hand params[:card_ids]
    end

    @hand.reload

    @hand.get_poker_hand_rank

    session[:winnings] = @current_user.calc_winnings(@hand.hand_rank, session[:bet])
    @current_user.update_balance session[:winnings]

    redirect_to @hand
  end

end
