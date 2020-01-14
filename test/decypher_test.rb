require_relative '../test/test_helper'
require_relative '../lib/enigma'
require_relative '../lib/shift'
require_relative '../lib/decypher'

class DecypherTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @shift = Shift.new
    @decypher = Decypher.new
  end

  def test_is_an_instance_of
    assert_instance_of Decypher, @decypher
  end
  def test_it_can_adjust_shift_number_for_decypher
    assert_equal (4), @decypher.adjust_number(18, 4)
    assert_equal (17), @decypher.adjust_number(4, 71)
  end

  def test_it_can_unchange_a_message
    assert_equal ("aaaabbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllll"),
    @decypher.unchange_message("qahsrbitscjutdkvuelwvfmxwgnyxhozyip zjqa krbalsc",
      {1=>16, 2=>27, 3=>34, 4=>45})
     assert_equal ("the eagle has landed."),
    @decypher.unchange_message("ihlruancu osh sscdlv.", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("abc"), @decypher.unchange_message("qbj", {1=>16, 2=>27, 3=>34, 4=>45})
      shift_hash = @decypher.shift_numbers("02715", "040895")
    assert_equal ("hello world"), @decypher.unchange_message("keder ohulw", shift_hash)
  end

  def test_it_can_decrypt
    assert_equal ({:decryption=>"hello world!", :key=>"21234", :date=>"130120"}),
    @decypher.decrypt("fuhsmpsvpa !", "21234", "130120", {1=>25, 2=>16, 3=>23, 4=>34})
    assert_equal ({:decryption=> "how are you?", :key=>"02345", :date=>"130120"}),
    @decypher.decrypt("nocrgrlrdoa?", "02345", "130120", {1=>06, 2=>27, 3=>34, 4=>45})
    assert_equal ({:decryption=>"how are you?", :key=>"18341", :date=>"101020"}),
    @decypher.decrypt("zugnsxpnpue?", "18341", "101020", {1=>18, 2=>87, 3=>38, 4=>41})
  end
end
