require "test_helper"

class HeaderMenuTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
  end

  test "メニュー項目 (login)" do
    login @user
    get root_path
    assert_response :redirect
    assert_redirected_to user_profile_path(@user.unique_user_id)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'nav.menu' do
      assert_select 'a', text: 'マイページ'
      assert_select 'a', text: '設定'
      assert_select 'a', text: 'ヘルプ'
      assert_select 'a', text: 'ログアウト'
      assert_select 'a', text: 'お問合せ'
      assert_select 'p.menu__user-name', text: @user.name
      assert_select '.menu__search-box'
    end
  end

  test "メニュー項目 (not_login)" do
    get root_path
    assert_response :success
    assert_template 'home/top'
    assert_select 'nav.menu' do
      assert_select 'a', text: 'TOP'
      assert_select 'a', text: '新規登録'
      assert_select 'a', text: 'ヘルプ'
      assert_select 'a', text: 'ログイン'
      assert_select '.menu__search-box'
    end
  end

end
