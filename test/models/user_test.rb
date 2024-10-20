require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:valid_user)
    @user.password = 'password'
  end

  test "正常な値での存在性の確認" do
    assert @user.valid?, @user.errors.full_messages.join(", ")
  end

  # =======================
  #   present validation
  # =======================

  test "unique_user_id 存在性確認" do
    @user.unique_user_id = ''
    assert_not @user.valid?
    assert_includes @user.errors[:unique_user_id], "を入力してください"
  end

  test "name 存在性確認" do
    @user.name = '';
    assert_not @user.valid?
    assert_includes @user.errors[:name], "を入力してください"
  end

  test "email 存在性確認" do
    @user.email = '';
    assert_not @user.valid?
    assert_includes @user.errors[:email], "を入力してください"
  end

  test "password 存在性確認" do
    @user.password = '';
    assert_not @user.valid?
    assert_includes @user.errors[:password], "を入力してください"
  end

  # =======================
  #   lenghth validation
  # =======================

  test "unique_user_id 文字数制限確認 (6~16)" do
    invalid_lengths = [5, 17]
    valid_lengths = [6, 16]

    invalid_lengths.each do |length|
      @user.unique_user_id = 'a' * length
      assert_not @user.valid?
    end

    valid_lengths.each do |length|
      @user.unique_user_id = 'a' * length
      assert @user.valid?
    end
  end

  test "name 文字数制限確認 (~18)" do
    invalid_lengths = [0, 19]
    valid_lengths = [1, 18]

    invalid_lengths.each do |length|
      @user.name = 'a' * length
      assert_not @user.valid?
    end

    valid_lengths.each do |length|
      @user.name = 'a' * length
      assert @user.valid?
    end
  end

  test "password 文字数制限確認 (8~16)" do
    invalid_lengths = [7, 17]
    valid_lengths = [8, 16]

    invalid_lengths.each do |length|
      @user.password = 'a' * length
      assert_not @user.valid?
    end

    valid_lengths.each do |length|
      @user.password = 'a' * length
      assert @user.valid?
    end
  end

  test "text 文字数制限確認（70文字以下)" do
    invalid_length = 71
    valid_length = 70
    @user.text = 'a' * invalid_length
    assert_not @user.valid?
    @user.text = 'a' * valid_length
    assert @user.valid?
  end

  # =======================
  #   Unique validation
  # =======================

  test "ID重複登録不可" do
    user1 = User.create(
      unique_user_id: 'test123',
      name: 'test1',
      email: 'test@example.com',
      password: 'password'
    )

    user2 = User.new(
      unique_user_id: 'test123',
      name: 'test2',
      email: 'test2@example.com',
      password: 'password'
    )

    assert_not user2.valid?
    assert_includes user2.errors[:unique_user_id], 'は既に使用されています'
  end

end
