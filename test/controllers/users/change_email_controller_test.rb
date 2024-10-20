require "test_helper"

class Users::ChangeEmailControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test 'メールアドレス変更ページへアクセス' do
    get edit_change_email_path
    assert_response :success
    assert_template 'users/change_email/edit'
  end

end
