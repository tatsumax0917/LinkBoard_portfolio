require "test_helper"

class MypageTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test "マイページ要素確認" do
    get user_profile_path(@user.unique_user_id)
    assert_select '.user-info__name', text: @user.name
    assert_select '.user-info__unique-user-id', text: "ID: #{@user.unique_user_id}"
    assert_select '.user-info__text', text: @user.text
    assert_select 'img.user-info__image[src*="default_profile"]'
    assert_select 'button#copy_url'
    assert_select 'ul.my-link__list' do
      assert_select 'a.my-link__link', text: 'リンクを設定する'
    end
  end


end
