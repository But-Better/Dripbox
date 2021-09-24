# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def send_information
    contact_data
    ContactMailer.send_information(@contact)
  end

  def send_to_management
    contact_data
    ContactMailer.send_to_management(
      @contact,
      User.create(
        username: 'Admin',
        email: 'Admin@Admin.admin',
        password: 'Admin123',
        email_confirmed: true,
        confirm_token: nil,
        contact_status: true
      )
    )
  end

  private

  def contact_data
    @contact = Contact.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      message: Faker::Lorem.sentence(word_count: 20)
    )
  end
end
