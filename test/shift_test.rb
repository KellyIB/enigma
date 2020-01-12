require_relative '../test/test_helper'
require_relative '../lib/enigma'
require 'time'
require_relative '../lib/shift'

class ShiftTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @shift = Shift.new
  end

  def test_is_an_instance_of
    assert_instance_of Shift, @shift
  end

  def test_it_has_attributes
    assert_equal ("0"), @shift.key
    assert_equal ("today"), @shift.date
  end

  def test_it_can_return_current_date_in_ddmmyy_string_format
  cur_date = Time.now.strftime('%d%m%y')
  assert_equal (cur_date), @shift.current_date(@shift.date)
  end

  def test_it_changes_key_instance_variable
    assert_equal ("0"), @shift.key
    @shift.random_key
    refute_equal ("0"), @shift.key
  end

  def test_it_can_change_string_key_to_hash_of_5_keys
    assert_equal ({1=>12, 2=>23, 3=>34, 4=>45}), @shift.keys_maker("12345")
  end

  def test_it_can_make_an_offset_array_to_use
    assert_equal (["4", "4", "0", "0"]), @shift.offset_maker("200120")
  end

  def test_it_can_find_the_shift_numbers
    assert_equal ({1=>16, 2=>27, 3=>34, 4=>45}), @shift.shift_numbers('12345', '200120')
    assert_equal ([" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
      "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]),
      @shift.alphabet_and_space_array
  end

  def test_it_can_change_a_message
    assert_equal (["t", "h", "e", " ", "e", "a", "g", "l", "e", " ", "h", "a",
      "s", " ", "l", "a", "n", "d", "e", "d", "."]),
      @shift.broken_message("The eagle has landed.")
    assert_equal ("ihlreqgsw xazrlqnkwd."),
      @shift.change_message("The eagle has landed.", {1=>16, 2=>27, 3=>34, 4=>45})
      assert_equal ("qbj"),
      @shift.change_message("abc", {1=>16, 2=>27, 3=>34, 4=>45})
      assert_equal ("q*j"),
      @shift.change_message("A*c", {1=>16, 2=>27, 3=>34, 4=>45})

  end
end
