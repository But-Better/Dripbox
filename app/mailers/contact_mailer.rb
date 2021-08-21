class ContactMailer < ApplicationMailer
  default from: 'dripbox@herokuapp.com'

  def send_information(contact)
    @contact = contact
    mail to: contact.email, subject: 'You has created a contact'
  end
end
