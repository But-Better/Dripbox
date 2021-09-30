require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase

  def login
    visit login_url
    fill_in 'floatingInput', with: @emailU1
    fill_in 'floatingPassword', with: @pwU1
    click_button 'commit'
    sleep 1
  end

  setup do
    @pwU1 = '123456789asdfghxA'
    @pwU2 = '123456789asdfghxB'

    @emailU1 = Faker::Internet.email
    @emailU2 = Faker::Internet.email


    @testUser1 = User.new(username: 'User1', email: @emailU1, password: @pwU1, email_confirmed: true,
                          confirm_token: nil)
    @testUser1.save!

    @testUser2 = User.new(username: 'User2', email: @emailU2, password: @pwU2, email_confirmed: true,
                          confirm_token: nil)
    @testUser2.save!
  end

  test 'access room creation' do
    login
    visit '/rooms'
    click_link 'Chatraum erstellen'
    sleep 1
    assert_selector 'h1', text: 'Einen neuen Raum erstellen'
  end

  test 'access created chatroom' do
    login
    visit new_room_url
    roomName = Faker::Beer.name
    fill_in 'room_name', with: roomName
    click_button 'commit'
    sleep 1
    assert_selector 'h1', text: "Aktueller Chatroom: #{roomName}"
  end

  test 'load preexisting chatroom messages' do

    #creating preexisting roommessages
    room1 = Room.new(name: 'Room 1')
    assert room1.save
    room2 = Room.new(name: 'Room 2')
    assert room2.save

    message1room1u1 = RoomMessage.new(room: room1, user: @testUser1, message: "Nachricht 1 von User 1");
    message2room1u1 = RoomMessage.new(room: room1, user: @testUser1, message: "Nachricht 2 von User 1");
    assert message1room1u1.save
    assert message2room1u1.save

    message1room1u2 = RoomMessage.new(room: room1, user: @testUser2, message: "Nachricht 1 von User 2");
    message2room1u2 = RoomMessage.new(room: room1, user: @testUser2, message: "Nachricht 2 von User 2");
    assert message1room1u2.save
    assert message2room1u2.save

    messageRoom2 = RoomMessage.new(room: room2, user: @testUser2, message: "Nachricht in Raum 2");
    assert messageRoom2.save

    #accessing the chatroom with existing messages
    login
    visit room_path(id: room1.id)
    sleep 1
    assert_selector 'h1', text: "Aktueller Chatroom: #{room1.name}"
    assert_selector 'li', class: "alert-success", text: "User1: Nachricht 1 von User 1"
    assert_selector 'li', class: "alert-success", text: "User1: Nachricht 2 von User 1"
    assert_selector 'li', class: "alert-danger", text: "User2: Nachricht 1 von User 2"
    assert_selector 'li', class: "alert-danger", text: "User2: Nachricht 1 von User 2"

    #accesing a differenct room with other messages
    visit room_path(id: room2.id)
    sleep 1
    assert_selector 'li', class: 'alert-danger', text: "User2: Nachricht in Raum 2"
  end
end
