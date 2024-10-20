require "test_helper"

class ChangePasswordTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test "表示要素の確認" do
    get edit_change_password_path
    assert_select 'input[type="password"][name="user[password]"]'
    assert_select 'input[type="password"][name="user[password_confirmation]"]'
    assert_select 'input[type="password"][name="user[current_password]"]'
    assert_select '.actions > input[type="submit"][name="commit"]'
  end

  test "パスワード変更成功" do
    initial_email_count = ActionMailer::Base.deliveries.size
    patch change_password_path, params: { user: {
      password: 'changepassword',
      password_confirmation: 'changepassword',
      current_password: 'password'
    } }
    @user.reload
    assert_redirected_to root_path
    follow_redirect!
    assert_redirected_to user_profile_path(@user.unique_user_id)
    follow_redirect!
    assert_template 'users/show'
    assert_select '.alert-notice', text: 'パスワードが変更されました'
    assert @user.valid_password?('changepassword')

    assert_equal initial_email_count + 1, ActionMailer::Base.deliveries.size
    email_to_user = ActionMailer::Base.deliveries.last
    assert_equal ['user@example.com'], email_to_user.to
    assert_equal '【LinkBoard】 パスワード変更完了のお知らせ', email_to_user.subject
  end

  test "パスワード変更失敗（blank）" do
    patch change_password_path, params: { user: {
      password: '',
      password_confirmation: '',
      current_password: 'password'
    } }

    assert_response :unprocessable_entity
    assert_template 'users/change_password/edit'
    assert_select '.invalid-feedback', count: 1, text: 'パスワードを入力してください'
  end

  test "パスワード変更失敗（空白混ざり）" do
    patch change_password_path, params: { user: {
      password: 'change password',
      password_confirmation: 'change password',
      current_password: 'password'
    } }

    assert_response :unprocessable_entity
    assert_template 'users/change_password/edit'
    assert_select '.invalid-feedback', count: 1, text: 'パスワードには空白を含めることはできません'
  end

  test "パスワード変更失敗（記号使ってる）" do
    patch change_password_path, params: { user: {
      password: 'changepassword!',
      password_confirmation: 'changepassword!',
      current_password: 'password'
    } }

    assert_response :unprocessable_entity
    assert_template 'users/change_password/edit'
    assert_select '.invalid-feedback', count: 1, text: 'パスワードはアルファベット（大文字・小文字）と数字のみ使用可能です'
  end
end
