require "application_system_test_case"

class RoomMessagesTest < ApplicationSystemTestCase

  def login
    visit login_url
    fill_in 'floatingInput', with: @emailU1
    fill_in 'floatingPassword', with: @pwU1
    click_button 'commit'
    sleep 2
  end

  def visit_chatroom
    login
    visit rooms_path
    click_link 'testRoom1'
    sleep 2
    assert_selector 'h1', text: "Aktueller Chatroom: #{@testRoom1.name}"
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

    @testRoom1 = Room.new(name: 'testRoom1')
    assert @testRoom1.save
  end


  test 'writing messages' do
    visit_chatroom

    emptyMessage = ''
    tooLongMessage = 'c' * 501
    goodMessage = 'unique Message i guess 93021845798312759'

    fill_in 'room_message_message_content', with: emptyMessage
    click_button 'commit'
    sleep 2

    fill_in 'room_message_message_content', with: tooLongMessage
    click_button 'commit'
    sleep 2

    fill_in 'room_message_message_content', with: goodMessage
    click_button 'commit'
    sleep 2

    #only one message should exist in this room
    assert_selector 'li', class: 'alert-success', text: "#{@testUser1.username}: #{goodMessage}"
  end

end
