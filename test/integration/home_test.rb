require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest

  test "topの要素確認" do
    get root_path
    assert_select 'h1', 'Link Board'
    assert_select 'div.hero__image'
    assert_select 'section.service'
    assert_select 'section.use-cases'
    assert_select 'section.questions'
    assert_select 'a', text: '無料で始める', count: 1
  end

end
