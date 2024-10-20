class ContactMailer < ApplicationMailer

  def contact_email_to_support(contact)
    @contact = contact
    mail(to: 'support@link-board.com', from: @contact.email, subject: '【LinkBoard】 新着のお問合せが届いてます')
  end

  def contact_email_to_user(contact)
    @contact = contact
    mail(to: @contact.email, from: 'support@link-board.com', subject: '【LinkBoard】 お問い合わせを受け付けました') do |format|
      format.html
      format.text
    end
  end

end
