class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def show
    user = User.find(params[:id])
    render json: {
      id: user.id,
      name: user.name,
      avatar_url: user.avatar.attached? ? url_for(user.avatar) : nil
    }
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { message: 'Avatar updated successfully', avatar_url: user.avatar.attached? ? url_for(user.avatar) : nil }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: {
      id: current_api_v1_user.id,
      name: current_api_v1_user.name,
      email: current_api_v1_user.email,
      avatar_url: current_api_v1_user.avatar.attached? ? url_for(current_api_v1_user.avatar) : ActionController::Base.helpers.asset_path("default-avatar.png")
    }
  end

  def update_avatar
  user = current_api_v1_user
  if user.update(user_params)
    render json: { message: 'Avatar updated successfully', avatar_url: user.avatar.attached? ? url_for(user.avatar) : nil }, status: :ok
  else
    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end
