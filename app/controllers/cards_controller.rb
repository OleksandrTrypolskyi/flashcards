class CardsController < ApplicationController
  before_action :logged_in?
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
    params.require(:card).permit(:original_text, :translated_text, :review_date, :picture)
  end

  def find_card
      @card = current_user.cards.find(params[:id])
  end
end
