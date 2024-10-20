require "test_helper"

class LinkTest < ActiveSupport::TestCase

  def setup
    user = users(:valid_user)
    @link = user.links.create!(link_name: 'Github', link_url: 'https://www.example.com', link_order: 1)
    assert @link.valid?
  end

  test "link_nameのバリデーションチェック" do
    @link.link_name = 'a' * 21
    assert_not @link.valid?
    @link.link_name = ''
    assert @link.valid?
  end

  test "link_urlのバリデーションチェック" do
    # 空欄OK
    @link.link_url = ''
    assert @link.valid?

    # URLフォーマット検査
    invalid_urls = %w[
      ftp://example.com
      http//example.com
      example.com
      www.example.com
      http://
    ]
    invalid_urls.each do |invalid_url|
      @link.link_url = invalid_url
      assert_not @link.valid?
    end

    valid_urls = %w[
      http://example.com
      https://example.com
      http://www.example.com
      https://sub.example.com/path
    ]
    valid_urls.each do |valid_url|
      @link.link_url = valid_url
      assert @link.valid?
    end

  end

  test "link_orderのバリデーションチェック" do
    @link.link_order = ''
    assert_not @link.valid?
  end

end
