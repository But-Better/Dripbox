# frozen_string_literal: true

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test 'room validation' do
    number_existing_rooms = Room.count

    room1 = Room.new(name: 'Room 1')
    room2 = Room.new(name: 'Room 2')
    room3 = Room.new(name: 'Room 3')

    # Räume mit unterschiedlichen Raumnamen werden gespeichert
    assert room1.save
    assert room2.save
    assert room3.save

    assert Room.count == number_existing_rooms + 3

    # Raum mit gleichem Raumnamen wird nicht gespeichert
    room_same_name = Room.new(name: 'Room 1')
    assert_not room_same_name.save

    # Raum mit leerem Raumnamen wird nicht gespeichert
    room_no_name = Room.new(name: '')
    assert_not room_no_name.save

    # Raum mit zu langem Raumnamen wird nicht gespeichert
    room_too_long = Room.new(name: '012345678901234567890')
    assert_not room_too_long.save
  end
end
