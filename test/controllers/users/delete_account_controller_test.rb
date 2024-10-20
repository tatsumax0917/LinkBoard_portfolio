require "test_helper"

class Users::DeleteAccountControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test "アカウント削除の動作と表示要素チェック" do
    get edit_delete_account_path
    assert_response :success
    assert_template 'users/delete_account/edit'
    assert_select 'input[name="user[current_password]"]'
    assert_select '.actions > input[type="submit"][name="commit"]'
    assert_select 'a.cancel-btn', text: '戻る' do |elements|
      elements.each do |element|
        assert_match %r{javascript:history\.back\(\)}, element['href']
      end
    end

    assert_difference 'User.count', -1 do
      delete delete_account_path, params: { user: { current_password: 'password'}}
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_template 'devise/sessions/new'
  end
end
