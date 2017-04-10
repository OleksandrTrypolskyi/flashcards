class CardsController < ApplicationController
  before_action :logged_in?
  before_action :has_decks?, only: [:new, :create]
  before_action :find_card, only: [:edit, :update, :show, :destroy]

  def index
      @cards = current_user.cards.all
  end

  def show; end

  def new
    @card = current_user.current_deck.cards.build
  end

  def create
    @card = current_user.current_deck.cards.build(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text,
                                 :review_date, :picture, :user_id)
  end

  def find_card
    if current_user.current_deck
      @card = current_user.current_deck.cards.find(params[:id])
    else
      @card = current_user.cards.find(params[:id])
    end
  end

  def has_decks?
    unless current_user.current_deck_id
      flash[:notice] = 'Cards can be created only in a deck. Please choose or create deck.'
      redirect_to decks_path
    end
  end
end
