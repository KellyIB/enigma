require_relative '../test/test_helper'
require_relative '../lib/enigma'
require 'time'
require_relative '../lib/shift'

class ShiftTest < Minitest::Test

  def setup
    # @enigma = Enigma.new("The eagle has landed.", key = "key", date = "today")
    @shift = Shift.new
  end

  def test_is_an_instance_of
    assert_instance_of Shift, @shift
  end

  def test_it_has_attributes
    assert_equal ("random_key"), @shift.key
    assert_equal ("today"), @shift.date
  end
end
