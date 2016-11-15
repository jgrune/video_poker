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

    # ########  validates bet amount #######
    #
    # if params[:bet].is_a? String
    #   flash[:alert] = "You must enter a valid bet amount"
    #   redirect_to new_hand_path
    if params[:bet].to_i > @current_user.dollars
      flash[:alert] = "You don't have enough money to bet that amount!"
      redirect_to new_hand_path
    elsif params[:bet].to_i < 0
      flash[:alert] = "You must enter a bet greater than zero"
      redirect_to new_hand_path
    else

      session[:bet] = params[:bet]
      # render plain: session.inspect
      @hand = Hand.create!
      @hand.user = @current_user
      @hand.save
      @hand.deal_hand

      redirect_to edit_hand_path(Hand.last)

    end
  end

  def edit
  end

  def update
    if params[:card_ids]
      @hand.update_hand params[:card_ids]
    end

    Card.reset_deck

    @hand.get_poker_hand_rank

    session[:winnings] = @current_user.calc_winnings(@hand.hand_rank, session[:bet])
    @current_user.update_balance session[:winnings]

    redirect_to @hand
  end


  def delete
  end

end
