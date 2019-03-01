class Api::V1::ToysController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]

  def index
    render json: ToySerializer.new(Toy.search(params))
  end

  def show
    render json: ToySerializer.new(Toy.find(params[:id]))
  end

  def create
    toy = current_user.toys.build toy_params
    if toy.save
      render json: ToySerializer.new(toy), status: 201
    else
      render json: { errors: ErrorSerializer.new(toy).serialized_json }, status: 422
    end
  end

  def update
    toy = current_user.toys.find params[:id]
    if toy.update(toy_params)
      render json: ToySerializer.new(toy), status: 200
    else
      render json: { errors: ErrorSerializer.new(toy).serialized_json }, status: 422
    end
  end

  def destroy
    toy = current_user.toys.find params[:id]
    toy.destroy
    head 204
  end

  private

  def toy_params
    params.require(:toy).permit(:title, :price, :published)
  end
end
