class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]

  def show
    @user = User.find params[:id]
    render json: UserSerializer.new(@user)
  end

  def create
    user = User.new user_params
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { errors: ErrorSerializer.new(user).serialized_json }, status: 422
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: UserSerializer.new(user), status: 200
    else
      render json: { errors: ErrorSerializer.new(user).serialized_json }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
