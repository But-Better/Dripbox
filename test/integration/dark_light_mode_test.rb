require "test_helper"

class DarkLightModeTest < ActionDispatch::IntegrationTest

  def login
    post '/login', params: { email: @testUser1.email, password: '123456789asdfghxA' }
  end

  setup do
    @testUser1 = User.new(username: Faker::Name.name, email: Faker::Internet.email, password: '123456789asdfghxA', email_confirmed: true,
                          confirm_token: nil)
    @testUser1.save!
  end

  test 'cookie_value' do
    login
    get dashboard_url
    assert_response :success

    assert_nil cookies[:theme]

    #mode ändern
    get root_path, params: {theme: 'dark'}
    assert_equal 'dark', cookies[:theme]

    get root_path, params: {theme: 'light'}
    assert_equal 'light', cookies[:theme]
  end

end
