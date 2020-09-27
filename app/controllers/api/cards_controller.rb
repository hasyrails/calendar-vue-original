class Api::CardsController < ApplicationController
  before_action :set_card, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @cards = Card.all
    render json: @cards
  end

  def show
    render json: @card
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      render json: @card
    else
      render json: @card.errors, status: :bad_request
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :bad_request
    end
  end

  def destroy
    @card.destroy!
    render json: @card
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.fetch(:card, {}).permit(:title, :body, :list_id, :created_at, :updated_at)
  end
end
