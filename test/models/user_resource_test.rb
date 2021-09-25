# frozen_string_literal: true

require 'test_helper'

class UserResourceTest < ActiveSupport::TestCase

  test 'no data given' do
    res = UserResource.new
    assert_not res.valid?
  end

  def make_valid_user
    User.new(username: Faker::Name.name,
             email: Faker::Internet.email,
             password: '123456789asdfghxA',
             email_confirmed: true,
             confirm_token: nil)
  end
  test 'all data given' do
    user = make_valid_user
    user.save

    res = user.user_resources.new(name: 'test_res', desc: 'some given description',
                                  tags: [Tag.create(name: 'Test')])

    # needs to be used for now, maybe changed later
    # Minitest mocking didn't work with validation
    res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')

    assert res.valid?
  end
  test 'user doesnt exist' do
    res = UserResource.new(user_id: 1, name: 'test_res', desc: 'some given description',
                           tags: [Tag.create(name: 'Test')])

    res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')

    assert_not res.valid?
  end
  test 'all data given but no file' do
    username = 'note'
    email = 'note@mail.com'
    password = '123456789asdfghxA'
    user = User.new(id: 1, username: username, email: email, password: password, email_confirmed: true,
                    confirm_token: nil)

    res = UserResource.new(user_id: user.id, name: 'test_res', desc: 'some given description',
                           tags: [Tag.create(name: 'Test')])
    assert_not res.valid?
  end
  test 'name too short' do
    user = make_valid_user
    user.save

    res = user.user_resources.new(name: 'a', desc: 'some given description',
                                  tags: [Tag.create(name: 'Test')])

    # needs to be used for now, maybe changed later
    # Minitest mocking didn't work with validation
    res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')

    assert_not res.valid?
  end
  test 'no given tags' do
    user = make_valid_user
    user.save

    res = user.user_resources.new(name: 'a', desc: 'some given description')

    # needs to be used for now, maybe changed later
    # Minitest mocking didn't work with validation
    res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')

    assert_not res.valid?
  end
  test 'no desc given' do
    user = make_valid_user
    user.save

    res = user.user_resources.new(name: 'ab', tags: [Tag.create(name: 'Test')])

    # needs to be used for now, maybe changed later
    # Minitest mocking didn't work with validation
    res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')

    assert_not res.valid?
  end
  test 'no name given' do
    user = make_valid_user
    user.save

    res = user.user_resources.new(name: 'ab', tags: [Tag.create(name: 'Test')])

    # needs to be used for now, maybe changed later
    # Minitest mocking didn't work with validation
    res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')

    assert_not res.valid?
  end
end
