class LanguageChange < ActionDispatch::IntegrationTest
  test "get default language" do
    get root_path
    assert_select "h2", "Please sign in"
  end

  test "change language" do
    get root_path + "?locale=en"
    assert_select "h2", "Please sign in"

    get root_path + "?locale=de"
    assert_select "h2", "Bitte einloggen"

    get root_path + "?locale=pepe"
    assert_select "h2", "Log dich ein MonkaS"
  end

  test "select via url a wrong language" do
    get root_path + "?locale=dasdad"
    assert_select "h2", "Please sign in"
  end
end
