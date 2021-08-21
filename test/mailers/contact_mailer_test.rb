require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  test "test_send_information" do
    name = "Peter Agile"
    email = "Peter-Meister@Agile.com"
    message = "Ich habe heute ein Contact formular erstellt und bug frei implementiert und es geht auch !!!"

    contact = Contact.create(name: name, email: email, message: message)
    send_email = ContactMailer.send_information(contact).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [contact.email], send_email.to

  end
end
