class Api::SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show update destroy]
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

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.permit(:body, :color, :start, :start_year, :start_month, :start_date, :end, :end_year, :end_month, :end_date, :card_id)
  end
end
