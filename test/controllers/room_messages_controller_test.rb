# frozen_string_literal: true

require 'test_helper'

class RoomMessagesControllerTest < ActionDispatch::IntegrationTest
  def login
    post '/login', params: { email: @testUser1.email, password: '123456789asdfghxA' }
  end

  setup do
    @testUser1 = User.new(username: 'User1', email: Faker::Internet.email, password: '123456789asdfghxA', email_confirmed: true,
                          confirm_token: nil)
    assert @testUser1.save

    @testUser2 = User.new(username: 'User2', email: Faker::Internet.email, password: '123456789asdfghxB', email_confirmed: true,
                          confirm_token: nil)
    assert @testUser2.save

    @testRoom1 = Room.new(name: 'testRoom1')
    assert @testRoom1.save
  end

  test 'message creation' do
    numberExistingMessages = RoomMessage.count
    # empty messages are not saved and reload site
    post rooms_path(id: @testRoom1.id), params: { roomMessage: { message: '' } }
    assert numberExistingMessages == RoomMessage.count
    assert_response :redirect

    # messages that are too long also arent saved
    tooLongMessage = 'c' * 501
    post rooms_path(id: @testRoom1.id), params: { roomMessage: { message: tooLongMessage } }
    assert numberExistingMessages == RoomMessage.count
    assert_response :redirect

    # valid messages are saved and reload site
    post rooms_path(id: @testRoom1.id), params: { roomMessage: { message: 'unique Message 1239873498' } }
    assert RoomMessage.find_by_message('unique Message 1239873498')
    assert (numberExistingMessages + 1) == RoomMessage.count
    assert_response :redirect
  end
end
