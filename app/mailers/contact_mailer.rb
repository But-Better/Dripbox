# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  default from: 'dripbox@herokuapp.com'

  def send_information(contact)
    @contact = contact
    mail to: contact.email, subject: 'You has created a contact'
  end

  def send_to_management(contact)
    @contact = contact
    mail to: contact.email, subject: "<#{contact.name}> has asked them | This email is from the contact form"
  end
end
