class Users::DeleteAccountController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_session_token

  def edit
    @user = current_user
  end

  def destroy
    @user = current_user
    if current_user.update_with_password(user_params)
      if @user.destroy
        redirect_to new_user_session_path, notice: 'アカウントを削除しました'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password)
  end
end
