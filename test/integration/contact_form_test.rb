require "test_helper"

class ContactFormTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test "表示中のフォームの数を確認" do
    login @user
    get contact_path
    assert_response :success
    assert_template 'contacts/new'
    assert_select 'input[name="contact[name]"]'
    assert_select 'input[name="contact[email]"]'
    assert_select 'textarea[name="contact[message]"]'
  end

  # ===================================
  #   お問合せ送信
  # ===================================

  test "お問い合わせ送信（成功）" do
    login @user
    # 送信前のメール数をカウント
    initial_email_count = ActionMailer::Base.deliveries.size
    # お問い合わせフォーム送信
    post contact_path, params: { contact: {
      name: 'Test User',
      email: 'test@gmail.com',
      message: '質問があります。'
    }}

    # お問い合わせ後はマイページへ
    assert_redirected_to user_profile_path(@user.unique_user_id)
    follow_redirect!
    assert_template 'users/show'
    # マイページに「お問い合わせを送信しました」とフラッシュ表示
    assert_select '.alert-notice', 'お問い合わせが完了しました'
    # 送信後のメール数が2になっている
    assert_equal initial_email_count + 2, ActionMailer::Base.deliveries.size

    # 自分へのメールを確認
    email_to_support = ActionMailer::Base.deliveries.first
    assert_equal ['support@link-board.com'], email_to_support.to
    assert_equal '【LinkBoard】 新着のお問合せが届いてます', email_to_support.subject
    # ユーザーへの自動返信メールを確認
    email_to_user = ActionMailer::Base.deliveries.last
    assert_equal ['test@gmail.com'], email_to_user.to
    assert_equal '【LinkBoard】 お問い合わせを受け付けました', email_to_user.subject
  end

  test "お問い合わせ送信（失敗）" do
    login @user
    get contact_path
    assert_template 'contacts/new'
    post contact_path, params: { contact: {
      name: '',
      email: '',
      message: ''
    }}
    assert_response :unprocessable_entity
    assert_template 'contacts/new'
    assert_select '.invalid-feedback', count: 2
    assert_select '.custom_error', count: 1
  end

end
