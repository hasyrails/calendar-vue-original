class Api::CardsController < ApplicationController
  before_action :set_card, only: %i[show update destroy]
  before_action :deadlined,  only: %i[show]
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user!

  def index
    @cards = Card.all
    # render json: @cards
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
      @schedules = Schedule.where(card_id: @card.id)
      if @schedules.present?
        @schedules.each do |schedule|
          schedule.update(schedule_params)
        end
      end
      render json: [{card: @card}, {schedules: @schedules}]
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
    params.permit(:id, :body, :description, :start, :deadline, :color, :scheduled, :schedulized, :deadlined, :done, :done_at,:list_id, :user_id)
  end

  def schedule_params
    params.permit(:body, :description, :start, :deadline, :color, :card_id,  :user_id,:done_at)
  end
end
