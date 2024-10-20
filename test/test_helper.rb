ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    # Deviseのテストヘルパーをインクルード
    include Devise::Test::IntegrationHelpers

    # テストを並列実行する設定（マシンのCPUコア数）
    parallelize(workers: :number_of_processors)

    # test/fixtures内のすべてをテストで利用可能にする設定
    fixtures :all

    # カスタムヘルパー
    def create_user(fixture: :valid_user, confirm: true, valid: true)
      user = users(fixture)
      user.update(password: 'password', password_confirmation: 'password')
      user.confirm if confirm
      assert user.valid? if valid
      user
    end

    # カスタムログインヘルパー
    def login(user)
      sign_in user
      user.update_session_token
    end

  end
end
