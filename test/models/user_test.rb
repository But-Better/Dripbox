# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User.new is not Valid' do
    user = User.new
    assert_not user.valid?, 'Test is User.new Valid'
  end

  test 'User create is not Valid' do
    user = User.create
    assert_not user.valid?
  end
end
