require "test_helper"

class HelpTest < ActionDispatch::IntegrationTest
  test "要素確認" do
    get help_path
    assert_select '.questions'
  end
end
