# frozen_string_literal: true

require 'test_helper'

class RoomMessageTest < ActiveSupport::TestCase
  setup do
    @test_user1 = users(:test_user1)

    @test_room1 = rooms(:test_room2)

  end

  test 'roommessage validation' do
    # a message NEEDS a room a user and messageContent
    message1 = RoomMessage.new(room: nil, user: @test_user1, message: 'Hello')
    assert_not message1.valid?

    message2 = RoomMessage.new(room: @test_room1, user: nil, message: 'Hello')
    assert_not message2.valid?

    message3 = RoomMessage.new(room: @test_room1, user: @test_user1, message: '')
    assert_not message3.valid?

    # this message fullfills all demands and should be saved
    message4 = RoomMessage.new(room: @test_room1, user: @test_user1, message: 'Hello')
    assert message4.valid?

    # but a message should not be too long
    too_long_message = 'c' * 501
    message5 = RoomMessage.new(room: @test_room1, user: @test_user1, message: too_long_message)
    assert_not message5.valid?
  end
end
