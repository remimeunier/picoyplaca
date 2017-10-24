require_relative "pico_y_placa"
require "test/unit"

class TestPicoYPlaca < Test::Unit::TestCase

  def test_outside_of_restricted_hours
    assert_equal(true, PicoYPlaca.new(plate_number: 'ABC-1234', date: '17/08/2018', time: '05:30').can_ride?)
  end

  def test_inside_of_restricted_hours
    assert_equal(false, PicoYPlaca.new(plate_number: 'ABC-1234', date: '17/08/2018', time: '08:30').can_ride?)
    assert_equal(true, PicoYPlaca.new(plate_number: 'ABC-1239', date: '17/08/2018', time: '08:30').can_ride?)
  end

  def test_invalide_date_error
    assert_raise(PicoYPlaca::InvalidDateError) { PicoYPlaca.new(plate_number: 'ABC-1234', date: '17/13/2018', time: '08:30') }
    assert_raise(PicoYPlaca::InvalidDateError) { PicoYPlaca.new(plate_number: 'ABC-1234', date: '', time: '08:30') }
  end

  def test_invalide_time_error
    assert_raise(PicoYPlaca::InvalidTimeError) { PicoYPlaca.new(plate_number: 'ABC-1234', date: '17/08/2018', time: '28:30') }
    assert_raise(PicoYPlaca::InvalidTimeError) { PicoYPlaca.new(plate_number: 'ABC-1234', date: '17/08/2018', time: '') }
  end

  def test_invalide_plate_error
    assert_raise(PicoYPlaca::InvalidPlateError) { PicoYPlaca.new(plate_number: 'ABC-1234D', date: '17/08/2018', time: '08:30') }
    assert_raise(PicoYPlaca::InvalidPlateError) { PicoYPlaca.new(plate_number: '', date: '17/08/2018', time: '08:30') }
  end
end
