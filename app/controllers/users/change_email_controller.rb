class Users::ChangeEmailController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if current_user.update_with_password(user_params)
      redirect_to root_path, notice: '【 要確認 】新しいメールアドレスに届いたメールのリンクを押して完了してください'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :email)
  end
end
