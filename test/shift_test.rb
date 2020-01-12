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

  def test_it_can_check_keys_and_select_a_random_key_if_needed
    assert_equal ("12345"), @shift.key_check("12345")
    assert_equal ("12345".length), @shift.key_check("12345".length)
    assert_equal (5), @shift.key_check("0").length
  end

  def test_it_can_check_date_and_select_current_date_if_needed_in_ddmmyy_string_format
    cur_date = Time.now.strftime('%d%m%y')
    date = "120120"
    assert_equal ("120120"), @shift.date_check(date)
    date = "040519"
     assert_equal ("040519"), @shift.date_check(date)
    date = "today"
    assert_equal (cur_date), @shift.date_check(date)
  end

  def test_it_can_change_string_key_to_hash_of_5_keys
    assert_equal ({1=>12, 2=>23, 3=>34, 4=>45}), @shift.keys_maker("12345")
  end

  def test_it_can_make_an_offset_array_to_use
    assert_equal (["4", "4", "0", "0"]), @shift.offset_maker("200120")
  end

  def test_it_can_find_the_shift_numbers_and_alphabet_array
    assert_equal ({1=>16, 2=>27, 3=>34, 4=>45}), @shift.shift_numbers('12345', '200120')
    assert_equal ({1=>03, 2=>27, 3=>73, 4=>20}), @shift.shift_numbers("02715", "040895")
    assert_equal ([" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
      "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]),
      @shift.alphabet_and_space_array
  end

  def test_it_can_add_one_to_counter_and_reset_to_one
    assert_equal (2), @shift.key_counter_check(1)
    assert_equal (3), @shift.key_counter_check(2)
    assert_equal (4), @shift.key_counter_check(3)
    assert_equal (1), @shift.key_counter_check(4)
  end

  def test_it_can_break_message_into_an_array_of_string
    assert_equal (["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"]),
    @shift.broken_message("Hello world")
    assert_equal (["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"]),
    @shift.broken_message("keder ohulw")
  end

  def test_it_can_check_index_and_find_correct_place_in_alphabet_array
    assert_equal (1), @shift.index_checker(55)
    assert_equal (26), @shift.index_checker(53)
    assert_equal (26), @shift.index_checker(26)
  end

  def test_it_can_change_a_message
    assert_equal (["t", "h", "e", " ", "e", "a", "g", "l", "e", " ", "h", "a",
      "s", " ", "l", "a", "n", "d", "e", "d", "."]),
      @shift.broken_message("The eagle has landed.")
      assert_equal ("ihl uancu osh sscdlv."),
      @shift.change_message("The eagle has landed.", {1=>16, 2=>27, 3=>34, 4=>45})
      assert_equal ("qbj"), @shift.change_message("abc", {1=>16, 2=>27, 3=>34, 4=>45})
      assert_equal ("q*j"), @shift.change_message("A*c", {1=>16, 2=>27, 3=>34, 4=>45})
      key = "02715"
      date = "040895"
      shift_hash = @shift.shift_numbers(key, date)
      assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}),
      @shift.encrypt("hello world", key, date, shift_hash)
  end

end
