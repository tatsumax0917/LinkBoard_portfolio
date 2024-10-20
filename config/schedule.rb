# # 環境変数RAILS_ENVが未設定の場合、デフォルトでproductionを使用
# rails_env = ENV['RAILS_ENV'] ||= 'production'

# # cronタスクの標準出力とエラー出力のログファイルを指定
# set :output, error: 'log/cron_error.log', standard: 'log/cron.log'

# # 環境変数をセット
# set :environment, rails_env

# # ENVから環境変数のキーと値を全て取り出してwheneverの設定の一部のenv( )にて
# # Cronジョブの環境変数をセットする
# ENV.each { |k, v| env(k, v) }

# # *** Job1 ***
# every 3.days, at: '4:30 am' do
#   runner "User.where(confirmed_at: nil).where('created_at < ?', 3.days.ago).destroy_all"
#   runner "puts '[#{Time.now}] - Not Confirmed User All Delete'"
# end
