class ApplicationController < ActionController::Base
  # before_action :verify_session_token

  include ApplicationHelper

  private

  # セッショントークンを検証
  def verify_session_token
    if user_signed_in?
      if current_user.session_token.nil?
        # 既存のセッションが異なる場合は、新しいセッションを作成
        sign_out(current_user)
        redirect_to new_user_session_path, alert: '他のデバイスでログアウトされたので、もう一度ログインしてください'
      end
    end
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def default_meta_tags
    {
      site: 'LinkBoard',
      title: '誰でもあなたの登録リンクにアクセス可能に',
      reverse: false,
      charset: 'utf-8',
      description: 'SNSやYoutubeチャンネルなど、知って欲しいリンクを登録して誰でも簡単にアクセス可能にできるサービスです。',
      keywords: 'SNS, Youtube, リンク管理, 配信, リスト, ブックマーク',
      canonical: request.original_url,
      separator: ' | ',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: helpers.image_url('twitter_card.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@linkboard_com',
        image: helpers.image_url('twitter_card.png')
      }
    }
  end

end
