class Users::ChangePasswordController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_session_token

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if change_password_params[:password].present?
      if @user.update_with_password(change_password_params)
        bypass_sign_in(@user, scope: :user)
        ChangeMailer.change_password(@user).deliver_now
        redirect_to root_path, notice: I18n.t('users.change_password.success')
      else
        render :edit, status: :unprocessable_entity
      end
    else
      @user.errors.add(:password, I18n.t('users.change_password.no_password'))
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def change_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end
