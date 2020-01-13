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
    assert_equal ({1=>18, 2=>83, 3=>34, 4=>41}), @shift.keys_maker("18341")
    assert_equal ({1=>12, 2=>23, 3=>34, 4=>45}), @shift.keys_maker("12345")
  end

  def test_it_can_make_an_offset_array_to_use
    assert_equal (["4", "4", "0", "0"]), @shift.offset_maker("200120")
  end

  def test_it_can_find_the_shift_numbers_and_alphabet_array
    assert_equal ({1=>16, 2=>27, 3=>34, 4=>45}), @shift.shift_numbers('12345', '200120')
    assert_equal ({1=>03, 2=>27, 3=>73, 4=>20}), @shift.shift_numbers("02715", "040895")
    assert_equal ({1=>18, 2=>84, 3=>34, 4=>41}), @shift.shift_numbers("18341", '101010')
    assert_equal ({1=>51, 2=>58, 3=>75, 4=>79}), @shift.shift_numbers("45678", "090909")
    assert_equal ({1=>18, 2=>87, 3=>34, 4=>41}), @shift.shift_numbers("18341", "101020")
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

  def test_it_can_check_index_and_find_correct_place_in_alphabet_array
    assert_equal (1), @shift.index_checker(55)
    assert_equal (26), @shift.index_checker(53)
    assert_equal (26), @shift.index_checker(26)
  end

  def test_it_can_change_a_message
    assert_equal ("ihl uancu osh sscdlv."),
    @shift.change_message("The eagle has landed.", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("qbj"), @shift.change_message("abc", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("q*j"), @shift.change_message("A*c", {1=>16, 2=>27, 3=>34, 4=>45})
      key = "02715"
      date = "040895"
      shift_hash = @shift.shift_numbers(key, date)
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}),
    @shift.encrypt("hello world", key, date, shift_hash)
    key = "18341"
    date = "101010"
    shift_hash = @shift.shift_numbers(key, date)
    assert_equal ({encryption: "zrc sul pra?", key: "18341", date: "101010"}),
    @shift.encrypt("how are you?", key, date, shift_hash)

  end

  def test_it_can_adjust_shift_number_for_decypher
    assert_equal (4), @shift.adjust_number(18, 4)
    assert_equal (17), @shift.adjust_number(4, 71)
  end

  def test_it_can_unchange_a_message
     assert_equal ("the eagle has landed."),
    @shift.unchange_message("ihl uancu osh sscdlv.", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("abc"), @shift.unchange_message("qbj", {1=>16, 2=>27, 3=>34, 4=>45})
    shift_hash = @shift.shift_numbers("02715", "040895")
    assert_equal ("hello world"), @shift.unchange_message("keder ohulw", shift_hash)
  end

  def test_it_can_encrypt
    assert_equal ({:encryption=>"fuhsm svpaz!", :key=>"21234", :date=>"130120"}),
    @shift.encrypt("Hello world!", "21234", "130120", {1=>25, 2=>16, 3=>23, 4=>34})
    assert_equal ({:encryption=> "noc grl doa?", :key=>"02345", :date=>"130120"}),
    @shift.encrypt("How are you?", "02345", "130120", {1=>06, 2=>27, 3=>34, 4=>45})
    assert_equal ({:encryption=>"zug sxp pue?", :key=>"18341", :date=>"101020"}),
    @shift.encrypt("How are you?", "18341", "101020", {1=>18, 2=>87, 3=>38, 4=>41})
  end

  def test_it_can_decrypt
    assert_equal ({:decryption=> "qlp joy gln?", :key=>"18341", :date=>"101010"}),
    @shift.decrypt("How are you?", "18341", "101010", {1=>18, 2=>84, 3=>34, 4=>41})
    assert_equal ({:decryption=> "plp ioy fln?", :key=>"19341", :date=>"101010"}),
    @shift.decrypt("How are you?", "19341", "101010", {1=>19, 2=>84, 3=>34, 4=>41})
  end


end
