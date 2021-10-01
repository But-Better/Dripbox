# frozen_string_literal: true

require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  def login
    post '/login', params: { email: @test_user1.email, password: '123456789asdfghxA' }
    post '/login', params: { email: @test_user2.email, password: '123456789asdfghxA' }
  end

  setup do
    @test_user1 = User.new(username: 'User1', email: Faker::Internet.email, password: '123456789asdfghxA', email_confirmed: true,
                           confirm_token: nil)
    @test_user1.save!

    @test_user2 = User.new(username: 'User2', email: Faker::Internet.email, password: '123456789asdfghxB', email_confirmed: true,
                           confirm_token: nil)
    @test_user2.save!
  end

  test 'access chatrooms site' do
    # if not logged in the user is redirected to login
    get rooms_path
    assert_response :redirect

    # if logged in the user should be able to access the chatrooms
    login
    get rooms_path
    assert_response :success
  end

  test 'create new chatroom and redirect' do
    # no access to roomcreation without login
    get new_room_path
    assert_response :redirect
    post rooms_path, params: { room: { name: 'room 1' } }
    assert_response :redirect

    login
    # a creation of a new room should lead to the chatroomsite and save the room in the db
    post rooms_path, params: { room: { name: 'room 1' } }
    assert Room.find_by_name('room 1')
    new_room = Room.find_by_name('room 1')
    assert_redirected_to new_room

    amount_of_saved_rooms = Room.count

    # it should not be possible to create two rooms with the same name
    post rooms_path, params: { room: { name: 'room 1' } }
    assert amount_of_saved_rooms == Room.count
    assert_select 'h2', 'Der gewählte Raumname ist schon vergeben/leer/oder zu lang, bitte wähle einen anderen Namen.'
  end

  test 'load preexisting chatrooms' do
    amount_of_saved_rooms = Room.count

    # creating preexisting rooms
    room1 = Room.new(name: 'Room 1')
    room2 = Room.new(name: 'Room 2')
    room3 = Room.new(name: 'Room 3')

    assert room1.save
    assert room2.save
    assert room3.save

    assert (amount_of_saved_rooms + 3) == Room.count

    login
    get rooms_path
    assert_select 'a', 'Room 1'
    assert_select 'a', 'Room 2'
    assert_select 'a', 'Room 3'
  end

  test 'access to chatroom' do
    # no access to chatrooms without login
    room1 = Room.new(name: 'Room 1')
    assert room1.save
    get rooms_path(id: room1.id)
    assert_response :redirect

    # access with login
    login
    get rooms_path(id: room1.id)
    assert_response :success
  end
end
