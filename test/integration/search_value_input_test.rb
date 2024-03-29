# frozen_string_literal: true

require 'test_helper'

class SearchValueInputTest < ActionDispatch::IntegrationTest
  setup do
    @testUser_1 = User.new(username: 'UserA', email: 'fake1@gmail.com', password: '123456789asdfghxA', email_confirmed: true,
                           confirm_token: nil)
    @testUser_1.save!

    testUser_1_resource_1 = @testUser_1.user_resources.new(name: 'User1_testResource1', desc: 'etwas user1 resc 1')
    testUser_1_resource_1.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_1_resource_1.tags = [Tag.new(name: 'File')]
    assert testUser_1_resource_1.save

    testUser_1_resource_2 = @testUser_1.user_resources.new(name: 'User1_testResource2', desc: 'etwas user1 resc 2')
    testUser_1_resource_2.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_1_resource_2.tags = [Tag.new(name: 'File1')]
    assert testUser_1_resource_2.save

    testUser_1_resource_3 = @testUser_1.user_resources.new(name: 'User1_testResource3', desc: 'etwas user1 resc 3')
    testUser_1_resource_3.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_1_resource_3.tags = [Tag.new(name: 'File2')]
    assert testUser_1_resource_3.save

    @testUser_2 = User.new(username: 'UserB', email: 'fake2@gmail.com', password: '123456789asdfghxA', email_confirmed: true,
                           confirm_token: nil)
    @testUser_2.save!
    testUser_2_resource_1 = @testUser_2.user_resources.new(name: 'User2_testResource1', desc: 'etwas user2 resc 1')
    testUser_2_resource_1.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_2_resource_1.tags = [Tag.new(name: 'File3')]
    assert testUser_2_resource_1.save

    testUser_2_resource_2 = @testUser_2.user_resources.new(name: 'User2_testResource2', desc: 'etwas user2 resc 2')
    testUser_2_resource_2.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_2_resource_2.tags = [Tag.new(name: 'File4')]
    assert testUser_2_resource_2.save

    testUser_2_resource_3 = @testUser_2.user_resources.new(name: 'User2_testResource3', desc: 'etwas user2 resc 3')
    testUser_2_resource_3.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'lost.jpg')
    testUser_2_resource_3.tags = [Tag.new(name: 'File5')]
    assert testUser_2_resource_3.save
  end

  def login_u1
    post login_path, params: { email: @testUser_1.email, password: '123456789asdfghxA' }
  end

  def login_u2
    post login_path, params: { email: @testUser_2.email, password: '123456789asdfghxA' }
  end

  test 'input for search exists in dashboard' do
    login_u1
    get dashboard_path
    assert_select 'input', '', 1
  end

  test 'search result site opens and gets input' do
    login_u1
    get '/searchresults?search_query=test'
    assert_response :success
    assert_select 'h2', 'Gefundene Dateien für: "test"'
  end

  test 'search result site shows everything for empty input' do
    login_u1
    get '/searchresults?search_query='
    assert_response :success
    assert_select 'h2', 'Gefundene Dateien für: ""'

    # alle User1 resource Namen
    assert_select 'i', { text: 'User1_testResource1', count: 1 }
    assert_select 'i', { text: 'User1_testResource2', count: 1 }
    assert_select 'i', { text: 'User1_testResource3', count: 1 }

    # alle User1 resource descriptions
    assert_select 'i', { text: 'etwas user1 resc 1', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 2', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 1 }

    # alle User2 resource Namen
    assert_select 'i', { text: 'User2_testResource1', count: 1 }
    assert_select 'i', { text: 'User2_testResource2', count: 1 }
    assert_select 'i', { text: 'User2_testResource3', count: 1 }

    # alle User2 resource descriptions
    assert_select 'i', { text: 'etwas user2 resc 1', count: 1 }
    assert_select 'i', { text: 'etwas user2 resc 2', count: 1 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 1 }
  end

  test 'search result site shows specific resources for specific full name input' do
    login_u1
    get '/searchresults?search_query=User1'
    assert_response :success
    assert_select 'h2', { text: 'Gefundene Dateien für: "User1"', count: 1 }

    # alle User1 resource Namen
    assert_select 'i', { text: 'User1_testResource1', count: 1 }
    assert_select 'i', { text: 'User1_testResource2', count: 1 }
    assert_select 'i', { text: 'User1_testResource3', count: 1 }

    # alle User1 resource descriptions
    assert_select 'i', { text: 'etwas user1 resc 1', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 2', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 1 }

    # die resourcen des anderen Users werden definitiv nicht angezeigt
    assert_select 'i', { text: 'User2_testResource1', count: 0 }
    assert_select 'i', { text: 'User2_testResource2', count: 0 }
    assert_select 'i', { text: 'User2_testResource3', count: 0 }

    assert_select 'i', { text: 'etwas user2 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 2', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 0 }
  end

  test 'search result site shows specific resources for specific partial name input' do
    login_u1
    get '/searchresults?search_query=serA'
    assert_response :success
    assert_select 'h2', { text: 'Gefundene Dateien für: "serA"', count: 1 }

    # alle User1 resource Namen
    assert_select 'i', { text: 'User1_testResource1', count: 1 }
    assert_select 'i', { text: 'User1_testResource2', count: 1 }
    assert_select 'i', { text: 'User1_testResource3', count: 1 }

    # alle User1 resource descriptions
    assert_select 'i', { text: 'etwas user1 resc 1', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 2', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 1 }

    # die resourcen des anderen Users werden definitiv nicht angezeigt
    assert_select 'i', { text: 'User2_testResource1', count: 0 }
    assert_select 'i', { text: 'User2_testResource2', count: 0 }
    assert_select 'i', { text: 'User2_testResource3', count: 0 }

    assert_select 'i', { text: 'etwas user2 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 2', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 0 }
  end

  test 'search result site shows specific resources for specific full filename input' do
    login_u1
    get '/searchresults?search_query=User1_testResource2'
    assert_response :success
    assert_select 'h2', { text: 'Gefundene Dateien für: "User1_testResource2"', count: 1 }

    # gesuchte Resource wurde gefunden
    assert_select 'i', { text: 'User1_testResource2', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 2', count: 1 }

    # nichts anderes wurde gefunden
    assert_select 'i', { text: 'etwas user2 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 2', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 0 }

    assert_select 'i', { text: 'etwas user2 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 2', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 0 }

    assert_select 'i', { text: 'etwas user1 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 0 }

    assert_select 'i', { text: 'etwas user1 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 0 }
  end

  test 'user overarching resources for input' do
    login_u1
    get '/searchresults?search_query=tEstResource2'
    assert_response :success
    assert_select 'h2', { text: 'Gefundene Dateien für: "tEstResource2"', count: 1 }

    # gesuchte Resource wurde gefunden
    assert_select 'i', { text: 'User1_testResource2', count: 1 }
    assert_select 'i', { text: 'etwas user1 resc 2', count: 1 }

    assert_select 'i', { text: 'User2_testResource2', count: 1 }
    assert_select 'i', { text: 'etwas user2 resc 2', count: 1 }

    # nichts anderes wurde gefunden
    assert_select 'i', { text: 'etwas user2 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 0 }

    assert_select 'i', { text: 'etwas user2 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user2 resc 3', count: 0 }

    assert_select 'i', { text: 'etwas user1 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 0 }

    assert_select 'i', { text: 'etwas user1 resc 1', count: 0 }
    assert_select 'i', { text: 'etwas user1 resc 3', count: 0 }
  end
end
