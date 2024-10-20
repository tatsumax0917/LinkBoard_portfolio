require "test_helper"

class MypageEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end


  test "マイページ編集画面へのアクセス" do
    get edit_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/edit'
  end

  test "マイページ編集画面の項目チェック" do
    get edit_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/edit'
    assert_select 'input#user_unique_user_id'
    assert_select 'button#id_edit_btn'
    assert_select 'input#user_name'
    assert_select 'input[type="file"]'
    assert_select 'textarea#user_text'
    assert_select 'div.user_email.disabled'
    assert_select 'div.change_email > a[href="/users/change_email/edit"]'
    assert_select 'div.user_password.disabled'
    assert_select 'div.change_password > a[href="/users/change_password/edit"]'

    assert_select 'h2.links__title', text: 'URLジェネレーター'
    assert_select 'select.generator-url__select'
    assert_select 'input.generator-url__account'
    assert_select 'button.generator-url__btn', text: 'URL生成'
    assert_select 'div.generator-result__url'
    assert_select 'button.generator-result__copy'

    assert_select 'h2.links__title', text: 'リンク設定'
    assert_select 'span.links__paste-btn'
    assert_select 'span.links__clear-btn'

    assert_select 'input[name$="[link_name]"]', count: 10
    assert_select 'input[name$="[link_url]"]', count: 10
  end

  test "項目が変更されるかの動作確認" do
    get edit_user_registration_path
    assert_response :success
    patch user_registration_path, params: { user: {
      unique_user_id: 'new_id',
      name: 'New Name',
      email: 'newemail@example.com',
      password: 'newpassword',
      password_confirmation: 'newpassword',
      text: 'New free text',
      links_attributes: [
         {
          link_name: 'Github',
          link_url: 'https://www.example.com',
          link_order: 1
        }
      ]
    } }
    @user.reload
    assert_response :redirect
    assert_redirected_to root_path
    follow_redirect!
    assert_redirected_to user_profile_path(@user.unique_user_id)
    follow_redirect!
    assert_template 'users/show'
    assert_select '.user-info__text', text: 'New free text'
    assert_equal 'new_id', @user.unique_user_id
    assert_equal 'New Name', @user.name
    assert_equal 'New free text', @user.text
    assert_select '.user-info__unique-user-id', text: "ID: #{@user.unique_user_id}"
    assert_select '.user-info__name', text: @user.name
    assert_select '.user-info__text', text: @user.text
    assert_select '.my-link__item', text: 'Github'

  end

  test '画像アップロードが正常動作しているか' do
    login @user
    image_path = Rails.root.join('test/fixtures/files/test_image_ok.jpg')
    image = fixture_file_upload(image_path, 'image/jpeg')

    patch user_registration_path, params: { user: { image: image } }
    assert_response :redirect
    assert_redirected_to root_path
    @user.reload
    assert @user.image.attached?
  end

end
