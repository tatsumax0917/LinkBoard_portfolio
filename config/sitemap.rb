SitemapGenerator::Sitemap.default_host = 'https://link-board.com'
SitemapGenerator::Sitemap.create do

  # 【他のパスを追加】
  # 各ユーザーのマイページ
  User.find_each do |user|
    add "/#{user.unique_user_id}", :lastmod => user.updated_at, :priority => 0.8, :changefreq => 'daily'
  end

  # =====【詳細説明】=====
  # add user_path(user.unique_user_id), 動的に追加されるURL
  # :lastmod => user.updated_at, 最終更新日
  # :priority => 0.8, 優先度 0.0 ~ 1.0 (1.0が優先度高い)
  # :changefreq => 'weekly' 予想される更新頻度
  # rake sitemap:refresh(このコマンドでサイトマップ生成)

end
