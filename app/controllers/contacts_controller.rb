class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_session_token

  def new
    @contact = Contact.new(name: current_user.name, email: current_user.email)
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.contact_email_to_support(@contact).deliver_now
      ContactMailer.contact_email_to_user(@contact).deliver_now
      flash[:notice] = "お問い合わせが完了しました"
      redirect_to user_profile_path(current_user.unique_user_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
