# frozen_string_literal: true

class LanguageChange < ActionDispatch::IntegrationTest
  test 'get default language' do
    get root_path
    assert_select 'h2', 'Please sign in'
  end

  test 'change language' do
    get "#{root_path}?locale=en"
    assert_select 'h2', 'Please sign in'

    get "#{root_path}?locale=de"
    assert_select 'h2', 'Bitte einloggen'

    get "#{root_path}?locale=pepe"
    assert_select 'h2', 'Log dich ein MonkaS'
  end

  test 'select via url a wrong language' do
    get "#{root_path}?locale=dasdad"
    assert_select 'h2', 'Please sign in'
  end

  test 'change language and redirect to another pages' do
    text1 = 'Neueste Uploads:'
    # <div id="heading2">
    # <h2>Neueste Uploads:</h2>
    # </div>

    text2 = 'Kennzeichnungen:'
    # <div id="heading2">
    # <h2>Kennzeichnungen:</h2>
    # </div>

    text3 = 'Nichts ausgewählt'
    # <div id="informationField">
    # <p>Nichts ausgewählt</p>
    # </div>

    get "#{root_path}?locale=de"

    post login_path, params: { user: { email: 'note@mail.com', password: '123456789asdfghxA' } }

    assert_select 'div#recentUploadsSection>div#heading2>h2', text1

    assert_select 'div#categorySection>div#heading2>h2', text2

    assert_select 'div#contentField>div#heading2>h2', text3
  end
end
