# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase

  # @param [String] name
  # @param [Integer] size
  # @param [String] type
  # @return [Minitest::Mock]
  # rubocop:disable Metrics/MethodLength
  def create_file_mock(name, size, type, creation_time)
    file = Minitest::Mock.new
    100.times do
      file.expect(:name, name)
      file.expect(:byte_filesize, size)
      file.expect(:is_a?, true, [UserResource])
      file.expect(:_has_attribute?, true, [Object])
      file.expect(:association, nil, [Object])
      file.expect(:_write_attribute, nil, [Object, Object])
      file.expect(:save, nil, [Object])
      file.expect(:type, type)
      file.expect(:creation_date, creation_time)
    end
    file
  end

  # rubocop:enable Metrics/MethodLength

  def create_user(name, mail)
    User.create(username: name, email: mail, password: '123456789asdfghxA', email_confirmed: true, confirm_token: nil)
  end

  test 'get top 5 files in terms of size' do

    files = []
    (1..10).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", ""))
    end

    user = create_user 'user1', 'user@user.com'

    user.user_resources.append files

    assert(user.top_five_files_by_size == [{ 'file': '10', 'size': 10 }, { 'file': '9', 'size': 9 },
                                           { 'file': '8', 'size': 8 }, { 'file': '7', 'size': 7 },
                                           { 'file': '6', 'size': 6 }])
  end
  test 'get top 5 files in terms of size given reverse' do

    files = []
    (1..10).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", ""))
    end

    user = create_user 'user1', 'user@user.com'

    user.user_resources.append files.reverse

    assert(user.top_five_files_by_size == [{ 'file': '10', 'size': 10 }, { 'file': '9', 'size': 9 },
                                           { 'file': '8', 'size': 8 }, { 'file': '7', 'size': 7 },
                                           { 'file': '6', 'size': 6 }])
  end
  test 'get number of files per type' do
    files = []
    (1..8).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", ""))
    end
    (9..10).each do |i|
      files.append(create_file_mock(i.to_s, i, "some other", ""))
    end

    user = create_user 'user1', 'user@user.com'
    user.user_resources.append files
    assert(user.number_of_files_per_type == [{ 'type': 'some', 'number': 8 }, { 'type': 'some other', number: 2 }])
  end
  test 'get upload file history' do
    files = []
    (1..3).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", "2021-09-06 11:42:29.946328".to_date))
    end
    (4..7).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", "2021-09-07 11:42:29.946328".to_date))
    end
    (8..10).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", "2021-09-08 11:42:29.946328".to_date))
    end

    user = create_user 'user1', 'user@user.com'
    user.user_resources.append files
    assert(user.upload_file_history == [{ 'date': "2021-09-06 11:42:29.946328".to_date, 'number': 3 }, { 'date': '2021-09-07 11:42:29.946328'.to_date, 'number': 4 }, { 'date': '2021-09-08 11:42:29.946328'.to_date, 'number': 3 }])

  end
  test 'get full upload size' do
    files = []
    (1..10).each do |i|
      files.append(create_file_mock(i.to_s, i, "some", ""))
    end

    user = create_user 'user1', 'user@user.com'
    user.user_resources.append files.reverse
    assert(user.total_upload_size == 55)
  end

end
