# frozen_string_literal: true

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test 'room validation' do
    numberExistingRooms = Room.count

    room1 = Room.new(name: 'Room 1')
    room2 = Room.new(name: 'Room 2')
    room3 = Room.new(name: 'Room 3')

    # Räume mit unterschiedlichen Raumnamen werden gespeichert
    assert room1.save
    assert room2.save
    assert room3.save

    assert Room.count == numberExistingRooms + 3

    # Raum mit gleichem Raumnamen wird nicht gespeichert
    roomSameName = Room.new(name: 'Room 1')
    assert_not roomSameName.save

    # Raum mit leerem Raumnamen wird nicht gespeichert
    roomNoName = Room.new(name: '')
    assert_not roomNoName.save

    # Raum mit zu langem Raumnamen wird nicht gespeichert
    roomTooLong = Room.new(name: '012345678901234567890')
    assert_not roomTooLong.save
  end
end
