# frozen_string_literal: true

require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @contacts = Contact.create(name: "Johannes kann es", email: "KannEs@Johannes.de", message: "i am jo---han---es and show me what your got")
  end

  test 'should get new' do
    get contacts_path
    assert_response :success
  end

  test 'Create Contact' do
    post contacts_url, contacts: { contacts: { name: @contacts.name, email: @contacts.email, message: @contacts.message } }
    assert_response :success
  end

  test 'Create Contact and check contactable users' do

  end

end
