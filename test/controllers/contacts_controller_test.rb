# frozen_string_literal: true

require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get contacts_path
    assert_response :success
  end

  test 'Create Contact' do
    post contacts_url,
         params: { contact: { name: 'Johannes kann es', email: 'KannEs@Johannes.de',
                              message: 'i am jo---han---es and show me what your got' } }
    assert Contact.find_by_email('KannEs@Johannes.de')

    get contacts_url
    assert_select "tr th#scope='row", 1
  end

  test 'Check validation from message length Contact' do
    post contacts_url,
         params: { contact: { name: 'Johannes kann es', email: 'KannGarnichtsEs@Johannes.de', message: 'i ' } }
    assert_not Contact.find_by_email('KannGarnichtsEs@Johannes.de')
  end

  test 'Check validation from email Contact' do
    post contacts_url,
         params: { contact: { name: 'Johannes kann es', email: 'KannGarnichtsEsJohannes.de',
                              message: 'Ich möchte mich Bewwerben TROLLLLLLLL' } }
    assert_not Contact.find_by_email('KannGarnichtsEsJohannes.de')
  end

  test 'Check validation from name Contact' do
    post contacts_url,
         params: { contact: { name: 'J', email: 'Peter@Johannes.de',
                              message: 'Ich möchte mich Bewwerben TROLLLLLLLL' } }
    assert_not Contact.find_by_email('Peter@Johannes.de')
  end
end
