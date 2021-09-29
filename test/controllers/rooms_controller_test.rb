# frozen_string_literal: true

require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest

  def login
    post '/login', params: { email: @testUser1.email, password: '123456789asdfghxA' }
  end

  setup do
    @testUser1 = User.new(username: Faker::Name.name, email: Faker::Internet.email, password: '123456789asdfghxA', email_confirmed: true,
                          confirm_token: nil)
    @testUser1.save!
  end

  test 'access chatrooms site' do
    #if not logged in the user is redirected to login
    get rooms_path
    assert_response :redirect

    #if logged in the user should be able to access the chatrooms
    login
    get rooms_path
    assert_response :success
  end

  test 'create new chatroom' do
    login
    #a creation of a new room should lead
    post rooms_path , params: {room: {name: 'room 1'}}
    assert_not Room.find_by(name: 'room 1').nil?
    @newRoom = Room.find_by(name: 'room 1')
    assert_redirected_to @newRoom
    @amountOfSavedRooms = Room.count

    #it should not be possible to create two rooms with the same name
    post rooms_path , params: {room: {name: 'room 1'}}
    assert @amountOfSavedRooms == Room.count
    assert_select 'h2', 'Der gewählte Raumname ist schon vergeben, bitte wähle einen anderen Namen.'
  end
end
