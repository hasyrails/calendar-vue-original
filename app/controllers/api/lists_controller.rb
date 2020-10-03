class Api::ListsController < ApplicationController
  before_action :set_list, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @lists = List.all
    render json: @lists
  end

  def show
    render json: @list
  end

  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list
    else
      render json: @list.errors, status: :bad_request
    end
  end

  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :bad_request
    end
  end

  def destroy
    @list.destroy!
    render json: @list
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.fetch(:list, {}).permit(:title)
  end

end
