# File for CardsController
class CardsController < ApplicationController
  before_action :logged_in?
  before_action :has_decks?, only: [:new, :create]
  before_action :find_card, only: [:edit, :update, :show, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def show; end

  def new
    @card = current_user.cards.build
  end

  def create
    @card = current_user.cards.build(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to cards_path
      flash[:success] = "Card #{@card.original_text} was successfly created."
    else
      render 'new'
      flash[:danger] = 'Something went wrong. Card was not created.'
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to cards_path
      flash[:success] = "Card #{@card.original_text} was successfly updated."
    else
      render 'edit'
      flash[:danger] = 'Something went wrong. Card was not updated.'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
    flash[:info] = 'Card was deleted.'
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text,
                                 :review_date, :picture, :user_id, :deck_id)
  end

  def find_card
    @card = if current_user.current_deck
              current_user.current_deck.cards.find(params[:id])
            else
              current_user.cards.find(params[:id])
            end
  end

  def has_decks?
    unless current_user.current_deck_id
      flash[:notice] = 'Cards can be created only in a deck.
                        Please choose or create deck.'
      redirect_to decks_path
    end
  end
end
