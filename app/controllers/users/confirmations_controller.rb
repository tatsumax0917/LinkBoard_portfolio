# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    @user = User.find_by(confirmation_token: params[:confirmation_token])

    if @user

      if @user.confirmed?
        # ユーザー認証済みの場合
        redirect_to new_user_session_path, alert: I18n.t('devise.confirmations.already_confirmed')
      elsif @user.confirmation_sent_at < 1.day.ago
        # 認証メールの有効期限切れで、認証が済んでない場合
        @user.send_confirmation_instructions # リンク付きメール自動再送
        redirect_to new_user_session_path, notice: I18n.t('devise.confirmations.link_expired')
      else
        # ユーザー認証がまだの場合
        super
      end
    end
  end

  # def show
  #   super
  #   flash[:notice] = 'メールアドレスの変更が完了しました'
  # end


  def show
    super
      if params[:action_type] == 'change_email'
        flash[:notice] = 'メールアドレスの変更が完了しました'
      else
        flash[:notice] = 'アカウント有効化が完了しました'
      end
  end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end

end
