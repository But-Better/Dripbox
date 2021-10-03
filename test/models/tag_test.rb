# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'create tag' do
    tag = Tag.new(name: Faker::Name.first_name)
    assert tag.valid?
    tag.save
    assert_equal tag, Tag.last
  end

  test 'validate name' do
    tag = Tag.new
    assert_not tag.valid?
  end

  test 'string to tag converter test' do
    tag = Tag.convert_string_to_tag('itsatag')
    assert tag.valid?
    assert_equal tag, Tag.last
  end
end
