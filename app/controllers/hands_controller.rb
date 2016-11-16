class HandsController < ApplicationController
  before_action :find_hand, only: [:show, :edit, :update]

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

    @hand.reload

    puts "*" * 50
    puts @hand.cards.inspect

    @hand.get_poker_hand_rank

    session[:winnings] = @current_user.calc_winnings(@hand.hand_rank, session[:bet])
    @current_user.update_balance session[:winnings]

    redirect_to @hand
  end

end
