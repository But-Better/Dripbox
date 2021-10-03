# frozen_string_literal: true

require 'test_helper'

class SearchResultsControllerTest < ActionDispatch::IntegrationTest

  def login_u1
    post login_path, params: { email: @testUser_1.email, password: '123456789asdfghxA' }
  end

  setup do
    @testUser_1 = User.new(username: 'UserA', email: 'fake1@gmail.com', password: '123456789asdfghxA', email_confirmed: true,
                           confirm_token: nil)
    @testUser_1.save!
  end

  test 'should get index' do

    #keine anzeige ohne eingeloggt zu sein
    get searchresults_path
    assert_response :redirect

    login_u1

    get searchresults_path
    assert_response :success
  end

  test 'insert in dashboard field should set @suchEingabe' do
    login_u1

    get searchresults_path, params: {search_query: 'SuchMich'}
    assert_equal 'SuchMich', @suchEingabe
  end
end
