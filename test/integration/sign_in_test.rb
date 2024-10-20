require "test_helper"

class SignInTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
  end

  test "ログイン画面へアクセス" do
    get new_user_session_path
    assert_response :success
    assert_template 'devise/sessions/new'
  end

  test "ログイン画面の要素チェック" do
    get new_user_session_path
    assert_select 'input#user_email'
    assert_select 'input#user_password'
    assert_select '.actions > input[type=submit]', count: 1
    assert_select 'a.forget_password', count: 1
    assert_select 'a.auth-mail_resend', count: 1
  end

  test "ログイン成功" do
    post user_session_path, params: { user: {
      email: @user.email,
      password: @user.password
    } }
    assert_response :redirect
    assert_redirected_to root_path # ログイン後はroot_pathへ行ってログイン状態で分岐しているから
    follow_redirect! # ここで実際に上のリダイレクト先へいく（root_pathへ)
    assert_redirected_to user_profile_path(@user.unique_user_id) # rootでは条件分岐があってログインしてるからリダイレクト先がある
    follow_redirect! # 上のリダイレクト先へ実際にいく
    assert_template 'users/show'
  end

  test "ログイン失敗" do
    post user_session_path, params: { user: {
      email: "",
      password: ""
    } }
    assert_response :unprocessable_entity
    assert_template 'devise/sessions/new'
    assert_select '.alert', 'IDかパスワードが間違っています。'
  end

end
