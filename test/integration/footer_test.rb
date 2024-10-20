require "test_helper"

class FooterTest < ActionDispatch::IntegrationTest

  test "要素のチェック" do
    get root_path
    assert_response :success
    assert_template :top
    assert_select 'h2.footer__logo'
    assert_select 'div.footer-nav' do
      assert_select 'li.footer-nav__item a[href="/users/sign_up"]', text: '新規登録'
      assert_select 'li.footer-nav__item a[href="/users/sign_in"]', text: 'ログイン'
      assert_select 'li.footer-nav__item a[href="/users"]', text: '検索'
      assert_select 'li.footer-nav__item a[href="#service"]', text: 'サービス内容'
      assert_select 'li.footer-nav__item a[href="#use-cases"]', text: 'ご利用例'
      assert_select 'li.footer-nav__item a[href="/help"]', text: 'よくある質問'
    end
    assert_select 'div.footer__developer'
    assert_select 'small.footer__copyright', text: '© 2024 Link Board'
  end
end
