# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def send_information
    ContactMailer.send_information(
      Contact.create(
        name: "Peter",
        email: "Enis@at.de",
        message: "Ja, lol bin ich schon drin so schnell ging das ich bin im Internet"
      ))
  end

  def send_to_management
    ContactMailer.send_to_management(
      Contact.create(
        name: "Peter",
        email: "Enis@at.de",
        message: "Ja, lol bin ich schon drin so schnell ging das ich bin im Internet"
      ),
      User.create(
        username: 'Admin',
        email: 'Admin@Admin.admin',
        password: 'Admin123',
        email_confirmed: true,
        confirm_token: nil,
        contact_status: true
      ))
  end
end
