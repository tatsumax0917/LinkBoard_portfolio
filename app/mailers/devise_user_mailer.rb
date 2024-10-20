class DeviseUserMailer < Devise::Mailer
  default from: 'info@link-board.com'
  layout "mailer"
  
  def confirmation_instructions(record, token, opts = {})
    if record.confirmed_at.nil?
      # 新規登録時のメール
      opts[:subject] = '【LinkBoard】 新規登録アカウントの確認'
    else
      # メールアドレス変更時のメール
      opts[:subject] = '【LinkBoard】 メールアドレス変更の確認'
    end
    super
  end

end
