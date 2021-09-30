# frozen_string_literal: true

require 'test_helper'

class RoomMessageTest < ActiveSupport::TestCase
  setup do
    @testUser1 = User.new(username: 'User1', email: Faker::Internet.email, password: '123456789asdfghxA', email_confirmed: true,
                          confirm_token: nil)
    assert @testUser1.save

    @testRoom1 = Room.new(name: 'testRoom 1')
    assert @testRoom1.save
  end

  test 'roommessage validation' do

    #a message NEEDS a room a user and messageContent
    message1 = RoomMessage.new(room: nil, user: @testUser1, message: 'Hello')
    assert_not message1.save

    message2 = RoomMessage.new(room: @testRoom1, user: nil, message: 'Hello')
    assert_not message2.save

    message3 = RoomMessage.new(room: @testRoom1, user: @testUser1, message: '')
    assert_not message3.save

    #this message fullfills all demands and should be saved
    message4 = RoomMessage.new(room: @testRoom1, user: @testUser1, message: 'Hello')
    assert message4.save

    #but a message should not be too long
    tooLongMessage = 'c' * 501
    message5 = RoomMessage.new(room: @testRoom1, user: @testUser1, message: tooLongMessage)
    assert_not message5.save
  end
end
