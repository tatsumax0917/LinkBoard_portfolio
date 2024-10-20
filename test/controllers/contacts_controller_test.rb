require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
  end

  test "[ログイン]お問い合わせページへアクセス" do
    login @user
    get contact_path
    assert_response :success
    assert_template 'contacts/new'
  end

  test "[未ログイン時]お問い合わせページへアクセス" do
    get contact_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_template 'devise/sessions/new'
  end

end
