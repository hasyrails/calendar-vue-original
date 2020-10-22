class Api::SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show update destroy done]
  skip_before_action :verify_authenticity_token

  def index
    @schedules = Schedule.all
    render json: @schedules
  end

  def show
    render json: @schedule
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: @schedule
    else
      render json: @schedule.errors, status: :bad_request
    end
  end

  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: @schedule.errors, status: :bad_request
    end
  end

  def destroy
    @schedule.destroy!
    render json: @schedule
  end

  def done
    @schedules = Schedule.where(card_id: @schedule.card_id)
    if @schedules.present?
      @schedules.each do |schedule|
        schedule.update(done: 'true')
      end
    end

    @card = Card.where(id: @schedule.card_id)
    if @card.present?
      @card.update(done: 'true')
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.permit(:id, :body, :description, :done, :commit, :color, :date, :date_year, :date_month, :date_day, :card_id, :start, :end)
  end
end
