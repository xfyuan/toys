class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!

  def index
    render json: OrderSerializer.new(current_user.orders)
  end

  def show
    render json:  OrderSerializer.new(current_user.orders.find params[:id])
  end

  def create
    order = current_user.orders.build
    order.build_placements params[:order][:toy_ids_and_quantities]

    if order.save
      order.reload
      render json: OrderSerializer.new(order), status: 201
    else
      render json: { errors: ErrorSerializer.new(order).serialized_json }, status: 422
    end
  end
end
