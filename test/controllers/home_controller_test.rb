require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
  end

  test "root_pathアクセス(login)" do
    login @user
    get root_path
    assert_response :redirect
    follow_redirect!
    assert_template 'users/show'
  end

  test "root_pathアクセス(not_login)" do
    get root_path
    assert_response :success
    assert_template 'home/top'
  end

  test "help_pathアクセス" do
    get help_path
    assert_response :success
    assert_template 'home/help'
  end

end
