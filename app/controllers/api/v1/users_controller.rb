require_relative '../../../controllers/application_controller'

class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create], raise: false
  before_action :authenticate_user!, only: [:show, :update], raise: false

  def create
    user = User.new(user_params_create)
    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, user: user.as_json(only: [:id, :name, :email]) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user.as_json(only: [:id, :name, :email])
  end

  def update
    if current_user.update(user_params_update)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params_create
    params.require(:user).permit(:name, :email, :password)
  end

  def user_params_update
    params.require(:user).permit(:name, :email)
  end
end