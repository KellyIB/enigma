require_relative '../test/test_helper'
require_relative '../lib/enigma'
require 'date'
require 'mocha/minitest'
require_relative '../lib/shift'

class ShiftTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @shift = Shift.new
  end

  def test_is_an_instance_of
    assert_instance_of Shift, @shift
  end

  def test_it_can_check_keys_and_select_a_random_key_if_needed
    assert_equal ("12345"), @shift.key_check("12345")
    assert_equal ("12345".length), @shift.key_check("12345".length)
    assert_equal (5), @shift.key_check("0").length
    key = @shift.stubs(:key_check).returns("12345")
    assert_equal ("12345"), @shift.key_check(key)
  end

  def test_it_can_select_current_date_in_ddmmyy_string_format
    cur_date = @shift.stubs(:date_check).returns("121212")
    date = "120120"
    assert_equal ("120120"), @shift.date_check(date)
    date = "040519"
    assert_equal ("040519"), @shift.date_check(date)
    assert_equal ("121212"), @shift.date_check(cur_date)
  end

  def test_it_can_change_string_key_to_hash_of_4_keys
    assert_equal ({1=>18, 2=>83, 3=>34, 4=>41}), @shift.keys_maker("18341")
    assert_equal ({1=>12, 2=>23, 3=>34, 4=>45}), @shift.keys_maker("12345")
  end

  def test_it_can_make_an_offset_array_to_use
    date = @shift.stubs(:date_check).returns("121212")
    assert_equal (["4", "4", "0", "0"]), @shift.offset_maker(date)
    assert_equal (["0", "1", "0", "0"]), @shift.offset_maker("101010")
  end

  def test_it_can_find_the_shift_numbers_and_alphabet_array
    assert_equal ({1=>16, 2=>27, 3=>34, 4=>45}), @shift.shift_numbers('12345', '200120')
    assert_equal ({1=>03, 2=>27, 3=>73, 4=>20}), @shift.shift_numbers("02715", "040895")
    assert_equal ({1=>18, 2=>84, 3=>34, 4=>41}), @shift.shift_numbers("18341", '101010')
    assert_equal ({1=>51, 2=>58, 3=>75, 4=>79}), @shift.shift_numbers("45678", "090909")
    assert_equal ({1=>18, 2=>87, 3=>34, 4=>41}), @shift.shift_numbers("18341", "101020")
  end
end
