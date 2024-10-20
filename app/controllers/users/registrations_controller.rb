# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :verify_session_token
  before_action :configure_account_update_params, only: [:update]
  # before_action :initialize_links, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  #   resource.links.build if resource.links.empty?
  # end

  # POST /resource
  # def create
    # super do |resource|
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  #   @user = current_user
  #   @user.links.build if @user
  # end

  # PUT /resource
  # def update
  #   super do |resource|
  #     if params[:user][:image].present?
  #       resource.image.attach(params[:user][:image])
  #     end
  #   end
  # end

  def update
    super do |resource|
      if params[:user][:cropped_image].present?
        # 画像データを一時ファイルに保存
        io = StringIO.new(Base64.decode64(params[:user][:cropped_image].split(',').last))
        io.class.class_eval { attr_accessor :original_filename, :content_type }
        io.original_filename = params[:user][:original_file_name] || 'cropped_image.jpg'
        io.content_type = 'image/jpeg'
        # 添付ファイルとしてユーザーに設定
        resource.image.attach(io: io, filename: io.original_filename, content_type: io.content_type)
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be e xpired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # def upload_image

  # end

  protected

  # def initialize_links
  #   resource.links.build if resource.links.empty?
  # end

  # ユーザー情報のアップデート時にパスワードの確認を要求しない
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # # 更新後のリダイレクト先を指定する
  # def after_update_path_for(resource)
  #   user_path(resource)
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :unique_user_id, :email])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :unique_user_id,
      :name,
      :text,
      :email,
      :image,
      links_attributes: [:id, :link_name, :link_url, :link_order, :_destroy]
    ])
  end

  # 新規登録後のリダイレクト先を設定
  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = "メールを確認してアカウントを有効化してください"
    new_user_session_path
  end

  # def user_params
  #   params.require(:user).permit(:name, :email, links_attributes: [:id, :link_name, :link_url, :_destroy])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   new_user_registration_path
  # end

end
