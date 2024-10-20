require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest

  test "新規登録画面へアクセス" do
    get new_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/new'
  end

  test "新規登録画面の要素チェック" do
    get new_user_registration_path
    assert_select 'input#user_unique_user_id'
    assert_select 'input#user_name'
    assert_select 'input#user_email'
    assert_select 'input#user_password'
    assert_select 'input#user_password_confirmation'
    assert_select '.actions > input[type=submit]', count: 1
  end

  test "新規登録成功" do
    new_user_params = {
      unique_user_id: "new_user",
      name: "New User",
      email: "new_user@example.com",
      password: "password123"
    }
    # ユーザーが増えたか確認
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: new_user_params }
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path

    # メール送信の確認
    assert_equal 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last

    # メールがmultipartかどうかチェック
    if email.multipart?
      # HTMLパートがあればそこからリンクを抽出
      email_body = email.html_part.body.encoded
    else
      # 単一パートの本文を使用
      email_body = email.body.encoded
    end

    # 有効化メールのリンクを抽出
    confirmation_link_match = email_body.match(/href="([^"]*)"/)
    confirmation_link = confirmation_link_match[1]
    confirmation_link = confirmation_link.gsub('&amp;', '&')

    # 有効化リンクにアクセス
    get confirmation_link

    # ユーザーが確認済みであることを確認
    user = User.find_by(email: "new_user@example.com")
    assert user.confirmed?
  end

  test "新規登録⇒リンク有効期限内に有効化" do
    # 新規ユーザーのパラメータ
    new_user_params = {
      unique_user_id: "new_user",
      name: "New User",
      email: "new_user@example.com",
      password: "password123"
    }

    # ユーザーが増えたか確認
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: new_user_params }
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path

    # メール送信の確認
    assert_equal 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last

    # メールがmultipartかどうかチェック
    email_body = if email.multipart?
      email.html_part.body.encoded
    else
      email.body.encoded
    end

    # 有効化メールのリンクを抽出
    confirmation_link_match = email_body.match(/href="([^"]*)"/)
    confirmation_link = confirmation_link_match[1]

    # 有効期限を切らせるために手動でメールの有効期限を短く設定
    # Userモデルのconfirmation_sent_atを過去に設定する
    user = User.find_by(email: "new_user@example.com")
    user.update(confirmation_sent_at: 2.days.ago)

    get confirmation_link
    assert_response :ok
    user.reload
    assert_not user.confirmed?
  end

  test "新規登録⇒リンク有効期限切れ⇒自動再送⇒有効化" do
    new_user_params = {
      unique_user_id: "new_user",
      name: "New User",
      email: "new_user@example.com",
      password: "password123"
    }
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: new_user_params }
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert_equal 1, ActionMailer::Base.deliveries.size

    # リンク有効期限切れ⇒再度新規登録⇒自動再送⇒有効化
    user = User.find_by(email: "new_user@example.com")
    user.update(confirmation_sent_at: 2.days.ago)
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: new_user_params }
    end
    assert_response :unprocessable_entity
    post user_confirmation_path, params: { user: { email: 'new_user@example.com' } }
    assert_equal 2, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last
    email_body = if email.multipart?
      email.html_part.body.encoded
    else
      email.body.encoded
    end
    confirmation_link_match = email_body.match(/href="([^"]*)"/)
    confirmation_link = confirmation_link_match[1]
    confirmation_link = confirmation_link.gsub('&amp;', '&')
    get confirmation_link
    user = User.find_by(email: 'new_user@example.com')
    assert user.confirmed?

  end

  test "新規登録⇒リンク付きメール紛失など⇒再送申請⇒有効化" do
    new_user_params = {
      unique_user_id: "new_user",
      name: "New User",
      email: "new_user@example.com",
      password: "password123"
    }
    # ユーザーが増えたか確認
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: new_user_params }
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path

    # ユーザーがまだ有効化されていないのを確認
    user = User.find_by(email: "new_user@example.com")
    assert_not user.confirmed?

    # === シチュエーション：メールを削除してしまったことにする ==

    post user_confirmation_path, params: { user: { email: 'new_user@example.com' } }
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_template 'devise/sessions/new'
    assert_select '.alert-notice', text: 'アカウント有効化のメールを送信しましたので確認してください。'
    # 有効化メールの再送依頼
    # 再送メール依頼後のメールの数(新規登録で1、再送で2（紛失は疑似的な話)
    assert_equal 2, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last

    # メールがmultipartかどうかチェック
    if email.multipart?
      # HTMLパートがあればそこからリンクを抽出
      email_body = email.html_part.body.encoded
    else
      # 単一パートの本文を使用
      email_body = email.body.encoded
    end
    # 有効化メールのリンクを抽出
    confirmation_link_match = email_body.match(/href="([^"]*)"/)
    confirmation_link = confirmation_link_match[1]
    confirmation_link = confirmation_link.gsub('&amp;', '&')

    # 有効化リンクにアクセス
    get confirmation_link
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_template 'devise/sessions/new'
    assert_select '.alert-notice', text: 'アカウント有効化が完了しました'

    # ユーザーが確認済み
    user = User.find_by(email: 'new_user@example.com')

    assert user.confirmed?
  end

  test "新規登録失敗" do
    post user_registration_path, params: { user: {
      unique_user_id: "",
      name: "",
      email: "",
      password: ""
    }}
    assert_response :unprocessable_entity
    assert_template 'devise/registrations/new'
    assert_select '.custom_error', 'IDを入力してください'
    assert_select '.invalid-feedback', 'ユーザー名を入力してください'
    assert_select '.invalid-feedback', 'メールアドレスを入力してください'
    assert_select '.invalid-feedback', 'パスワードを入力してください'
  end

end
