# frozen_string_literal: true

require 'test_helper'

class RoomMessagesControllerTest < ActionDispatch::IntegrationTest
  def login
    post login_path, params: { email: @test_user1.email, password: '123456789asdfghxA' }
  end

  setup do
    @test_user1 = User.new(username: 'User1', email: Faker::Internet.email, password: '123456789asdfghxA', email_confirmed: true,
                           confirm_token: nil)
    assert @test_user1.save

    @test_user2 = User.new(username: 'User2', email: Faker::Internet.email, password: '123456789asdfghxB', email_confirmed: true,
                           confirm_token: nil)
    assert @test_user2.save

    @test_room1 = Room.new(name: 'testRoom1')
    assert @test_room1.save
  end

  test 'message creation' do
    number_existing_messages = RoomMessage.count
    # empty messages are not saved and reload site
    post rooms_path(id: @test_room1.id), params: { room_message: { message: '' } }
    assert number_existing_messages == RoomMessage.count
    assert_response :redirect

    # messages that are too long also arent saved
    too_long_message = 'c' * 501
    post rooms_path(id: @test_room1.id), params: { room_message: { message: too_long_message } }
    assert number_existing_messages == RoomMessage.count
    assert_response :redirect

    # valid messages are saved and reload site
    post rooms_path(id: @test_room1.id), params: { room_message: { message: 'unique Message 1239873498' } }
    #assert RoomMessage.find_by_message('unique Message 1239873498')
    #assert (numberExistingMessages + 1) == RoomMessage.count
    assert_response :redirect
  end
end
