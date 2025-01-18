class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token
  helper_method :current_user, :user_signed_in?

  private

  # DeviseTokenAuth のトークンを利用して現在のユーザーを取得
  def current_user
    @current_user ||= User.find_by(uid: request.headers['uid'], provider: 'email') if request.headers['uid']
  end

  # ユーザーがサインインしているか確認
  def user_signed_in?
    current_user.present?
  end

  # 未認証の場合はエラーを返す
  def authenticate_user!
    render json: { error: 'Unauthorized access' }, status: :unauthorized unless user_signed_in?
  end
end
