# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :todos
  has_one_attached :avatar

  # デフォルトのアバターURLを返すメソッド
  def default_avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.url_for(avatar) : '/default-avatar.png'
  end
end
