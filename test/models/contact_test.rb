# frozen_string_literal: true

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test 'contact is empty' do
    contact = Contact.create(name: '', email: '', message: '')
    assert_not contact.valid?
  end

  test 'contact is valid' do
    contact = Contact.create(name: 'Peter', email: 'Peter@Peter.de', message: 'opandasd0o312kd<%$&$§/§""')
    assert contact.valid?
  end

  test 'message length > 9' do
    contact = Contact.create(name: 'Peter', email: 'Peter@Peter.de', message: '12345678')
    assert_not contact.valid?
  end
end
