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
    assert_nil @shift.key
    assert_equal ("today"), @shift.date
  end

  def test_it_can_return_current_date_in_ddmmyy_string_format
  cur_date = Time.now.strftime('%d/%m/%y')
  assert_equal (cur_date), @shift.current_date(@shift.date)
  end

  def test_it_changes_key_instance_variable
    refute nil, @shift.random_key
  end

  def test_it_can_change_string_key_to_hash_of_5_keys
    assert_equal ({"a"=>12, "b"=>23, "c"=>34, "d"=>45}), @shift.keys_maker("12345")
  end

  def test_it_can_make_an_offset_array_to_use
    assert_equal (["4", "4", "0", "0"]), @shift.offset_maker("200120")
  end

  def test_it_can_find_the_shift_numbers
    assert_equal ({"a"=>16, "b"=>27, "c"=>34, "d"=>45}), @shift.shift_numbers("12345", "200120")
  end

end
