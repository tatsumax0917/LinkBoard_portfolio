# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :verify_session_token, except: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    if current_user.session_token.nil?
      current_user.update_session_token
    end
  end

  # DELETE /resource/sign_out
  def destroy
    current_user.reset_session_token if user_signed_in?
    super
    flash[:notice] = "ログアウトしました"
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
