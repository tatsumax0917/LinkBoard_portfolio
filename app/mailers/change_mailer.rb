class ChangeMailer < ApplicationMailer

  def change_password(user)
    @user = user
    mail(
      to: @user.email,
      subject: '【LinkBoard】 パスワード変更完了のお知らせ'
    )
  end

end
