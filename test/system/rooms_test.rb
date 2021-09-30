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

  test 'access show' do
    login
    visit new_room_url
    roomName = Faker::Beer.name
    fill_in 'room_name', with: roomName
    click_button 'commit'
    sleep 1
    assert_selector 'h1', text: "Aktueller Chatroom: #{roomName}"
  end
end
