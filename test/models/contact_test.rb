require "test_helper"

class ContactTest < ActiveSupport::TestCase

  def setup
    @contact = Contact.new(
      name: 'john',
      email: 'john@gmail.com',
      message: 'hello'
    )
  end

  test "should be valid" do
    assert @contact.valid?
  end

  test "should be invalid without a name" do
    @contact.name = ''
    assert_not @contact.valid?
  end

  test "should be invalid an email" do
    @contact.email = ''
    assert_not @contact.valid?
  end

  test "should be invalid without a message" do
    @contact.message = ''
    assert_not @contact.valid?
  end
end
