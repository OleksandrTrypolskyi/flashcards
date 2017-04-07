class DecksController < ApplicationController
  before_action :logged_in?
  before_action :find_deck, only: [:show, :edit, :upadate, :destroy]

  def show; end

  def new
      @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to @deck
    else
      render 'new'
    end
  end

  def edit; end

  def update
  end

  def destroy
  end

  private
  def deck_params
    params.require(:deck).permit(:name)
  end

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end
end