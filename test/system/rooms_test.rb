# frozen_string_literal: true

require 'application_system_test_case'

class RoomsTest < ApplicationSystemTestCase
  def login
    visit login_url
    fill_in 'floatingInput', with: @email_u1
    fill_in 'floatingPassword', with: @pw_u1
    click_button 'commit'
    sleep 1
  end

  setup do
    @pw_u1 = '123456789asdfghxA'
    @pw_u2 = '123456789asdfghxB'

    @email_u1 = Faker::Internet.email
    @email_u2 = Faker::Internet.email

    @test_user1 = User.new(username: 'User123', email: @email_u1, password: @pw_u1, email_confirmed: true,
                           confirm_token: nil)
    @test_user1.save!

    @test_user2 = User.new(username: 'User234', email: @email_u2, password: @pw_u2, email_confirmed: true,
                           confirm_token: nil)
    @test_user2.save!
  end

  test 'access room creation' do
    login
    visit rooms_path
    click_link 'Chatraum erstellen'
    sleep 1
    assert_selector 'h1', text: 'Einen neuen Raum erstellen'
  end

  test 'creating chatroom and accessing it' do
    login
    visit new_room_url
    room_name = Faker::Beer.name
    fill_in 'room_name', with: room_name
    click_button 'commit'
    sleep 2
    assert_selector 'h1', text: "Aktueller Chatroom: #{room_name}"
  end

  test 'load preexisting chatroom messages' do
    # creating preexisting roommessages
    room1 = Room.new(name: 'Room 1')
    assert room1.save
    room2 = Room.new(name: 'Room 2')
    assert room2.save

    message1_room1_u1 = RoomMessage.new(room: room1, user: @test_user1, message: 'Nachricht 1 von User 1')
    message2_room1_u1 = RoomMessage.new(room: room1, user: @test_user1, message: 'Nachricht 2 von User 1')
    assert message1_room1_u1.save
    assert message2_room1_u1.save

    message1_room1_u2 = RoomMessage.new(room: room1, user: @test_user2, message: 'Nachricht 1 von User 2')
    message2_room1_u2 = RoomMessage.new(room: room1, user: @test_user2, message: 'Nachricht 2 von User 2')
    assert message1_room1_u2.save
    assert message2_room1_u2.save

    messageRoom2 = RoomMessage.new(room: room2, user: @test_user2, message: 'Nachricht in Raum 2')
    assert messageRoom2.save

    # accessing the chatroom with existing messages
    login
    visit room_path(id: room1.id)
    sleep 1
    assert_selector 'h1', text: "Aktueller Chatroom: #{room1.name}"
    assert_selector 'li', class: 'alert-success', text: 'User123: Nachricht 1 von User 1'
    assert_selector 'li', class: 'alert-success', text: 'User123: Nachricht 2 von User 1'
    assert_selector 'li', class: 'alert-danger', text: 'User234: Nachricht 1 von User 2'
    assert_selector 'li', class: 'alert-danger', text: 'User234: Nachricht 1 von User 2'

    # accesing a differenct room with other messages
    visit room_path(id: room2.id)
    sleep 1
    assert_selector 'li', class: 'alert-danger', text: 'User234: Nachricht in Raum 2'
  end
end
