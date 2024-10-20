class UsersController < ApplicationController
  before_action :set_meta_tags_for_user, only: [:show]
  before_action :verify_session_token

  def show
    @user = User.find_by!(unique_user_id: params[:unique_user_id])
  rescue ActiveRecord::RecordNotFound
    # ユーザーが見つからない場合にリダイレクトする
    redirect_to users_path, alert: "該当するユーザーが見つかりませんでした"
  end

  def index
    if params[:search_text].present?
      @users = User.where('name LIKE ? OR unique_user_id LIKE ? OR text LIKE ?', "%#{params[:search_text]}%", "%#{params[:search_text]}%", "%#{params[:search_text]}%").page(params[:page]).per(50)
    else
      @users = User.all.page(params[:page]).per(50)
    end
  end

  private

  def set_meta_tags_for_user
    @user = User.find_by!(unique_user_id: params[:unique_user_id])
    @default_meta_tags = default_meta_tags.merge(
      title: "#{@user.name}",
      reverse: true,
      description: "#{@user.name}のプロフィールページです。",
      url: user_profile_url(@user.unique_user_id)
    )
  end

end
