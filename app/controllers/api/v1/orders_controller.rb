class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!

  def index
    render json: OrderSerializer.new(current_user.orders)
  end
end
