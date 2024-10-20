module ApplicationHelper

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
        image: image_url('twitter_card.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@linkboard_com',
        image: image_url('twitter_card.png')
      }
    }
  end
end
