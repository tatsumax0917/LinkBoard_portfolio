require "test_helper"

class ChangeEmailTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test "表示要素の確認" do
    get edit_change_email_path
    assert_select 'input[type="email"][name="user[email]"]'
    assert_select 'input[type="password"][name="user[current_password]"]'
    assert_select '.actions > input[type="submit"][name="commit"]'
  end

  test "メールアドレス変更（成功）" do
    initial_email_count = ActionMailer::Base.deliveries.size
    patch change_email_path, params: { user: {
      email: 'change_email@example.com',
      current_password: 'password'
    }}
    # メールが送信された
    assert_equal initial_email_count + 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last
    assert_equal ['change_email@example.com'], email.to
    assert_equal '【LinkBoard】 メールアドレス変更の確認', email.subject
    follow_redirect!
    follow_redirect!
    assert_template 'users/show'
    assert_select '.alert-notice', text: '【 要確認 】新しいメールアドレスに届いたメールのリンクを押して完了してください'

    #   # メールがmultipartかどうかチェック
    if email.multipart?
      # HTMLパートがあればそこからリンクを抽出
      email_body =email.html_part.body.encoded
    else
      # 単一パートの本文を使用
      email_body =email.body.encoded
    end

    # メールのリンクを抽出
    link_match = email_body.match(/href="([^"]*)"/)
    link = link_match[1]
    link = link.gsub('&amp;', '&')

    # メールのURLへアクセス
    get link
    login @user
    get root_path
    assert_response :redirect
    assert_redirected_to user_profile_path(@user.unique_user_id)
    follow_redirect!
    assert_template 'users/show'
    # フラッシュ
    assert_select '.alert-notice', text: 'メールアドレスの変更が完了しました'
    # リロード
    @user.reload
    # メールが変更されているか
    assert_equal 'change_email@example.com', @user.email
  end


  test "メールアドレス変更（失敗）" do
    initial_email_count = ActionMailer::Base.deliveries.size
    patch change_email_path, params: { user: {
      email: '',
      current_password: ''
    }}
    assert_response :unprocessable_entity
    assert_select '.invalid-feedback', count: 1, text: 'メールアドレスを入力してください'
    assert_select '.invalid-feedback', count: 1, text: '現在のパスワードを入力してください'
  end

end
