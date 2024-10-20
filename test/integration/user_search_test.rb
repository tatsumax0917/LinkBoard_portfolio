require "test_helper"

class UserSearchTest < ActionDispatch::IntegrationTest
  test "検索結果の表示（該当者有り）" do
    text = 'user'
    get users_path, params: { search_text: text }
    assert_template 'users/index'
    assert_select '.search__user-name', text: text
  end

  test "検索結果の表示（該当者なし）" do
    text = 'nothing'
    get users_path, params: { search_text: text }
    assert_template 'users/index'
    assert_select 'li', text: '該当するユーザーが見つかりませんでした'
  end
end
