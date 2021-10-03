# frozen_string_literal: true

require 'application_system_test_case'

class RoomMessagesTest < ApplicationSystemTestCase
  def login
    visit login_url
    fill_in 'floatingInput', with: @email_u1
    fill_in 'floatingPassword', with: @pw_u1
    click_button 'commit'
    sleep 2
  end

  def visit_chatroom
    login
    visit rooms_path
    click_link @test_room1.name
    sleep 2
    assert_selector 'h1', text: "Aktueller Chatroom: #{@test_room1.name}"
  end

  setup do
    @pw_u1 = '123456789asdfghxA'
    @pw_u2 = '123456789asdfghxB'

    @email_u1 = Faker::Internet.email
    @email_u2 = Faker::Internet.email

    @test_user1 = User.new(username: 'User1123', email: @email_u1, password: @pw_u1, email_confirmed: true,
                           confirm_token: nil)
    @test_user1.save!

    @test_user2 = User.new(username: 'User2234', email: @email_u2, password: @pw_u2, email_confirmed: true,
                           confirm_token: nil)
    @test_user2.save!

    @test_room1 = Room.new(name: 'testRoom11234')
    assert @test_room1.save
  end

  test 'writing messages' do
    visit_chatroom

    empty_message = ''
    too_long_message = 'c' * 501
    good_message = 'unique Message i guess 93021845798312759'

    fill_in 'room_message_message_content', with: empty_message
    click_button 'commit'
    sleep 2

    fill_in 'room_message_message_content', with: too_long_message
    click_button 'commit'
    sleep 2

    fill_in 'room_message_message_content', with: good_message
    click_button 'commit'
    sleep 2

    # only one message should exist in this room
    assert_selector 'li', class: 'alert-success', text: "#{@test_user1.username}: #{good_message}"
  end
end
