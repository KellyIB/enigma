require_relative '../test/test_helper'
require_relative '../lib/enigma'
require_relative '../lib/shift'
require_relative '../lib/cypher'

class CypherTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @shift = Shift.new
    @cypher = Cypher.new
  end

  def test_is_an_instance_of
    assert_instance_of Cypher, @cypher
  end

  def test_it_can_check_index_and_find_correct_place_in_alphabet_array
    assert_equal (1), @cypher.index_checker(55)
    assert_equal (26), @cypher.index_checker(53)
    assert_equal (26), @cypher.index_checker(26)
  end

  def test_it_can_change_a_message
    assert_equal ("ihlruancu osh sscdlv."),
    @cypher.change_message("The eagle has landed.", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("qbj"), @cypher.change_message("abc", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("q*j"), @cypher.change_message("A*c", {1=>16, 2=>27, 3=>34, 4=>45})
    assert_equal ("qahsrbitscjutdkvuelwvfmxwgnyxhozyip zjqa krbalsc"),
    @cypher.change_message("Aaaabbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllll",
      {1=>16, 2=>27, 3=>34, 4=>45})
  end

  def test_it_can_encrypt
    assert_equal ({:encryption=>"fuhsmpsvpa !", :key=>"21234", :date=>"130120"}),
    @cypher.encrypt("Hello world!", "21234", "130120", {1=>25, 2=>16, 3=>23, 4=>34})
    assert_equal ({:encryption=> "nocrgrlrdoa?", :key=>"02345", :date=>"130120"}),
    @cypher.encrypt("How are you?", "02345", "130120", {1=>06, 2=>27, 3=>34, 4=>45})
    assert_equal ({:encryption=>"zugnsxpnpue?", :key=>"18341", :date=>"101020"}),
    @cypher.encrypt("How are you?", "18341", "101020", {1=>18, 2=>87, 3=>38, 4=>41})
      key = "02715"
      date = "040895"
      shift_hash = @cypher.shift_numbers(key, date)
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}),
    @cypher.encrypt("hello world", key, date, shift_hash)
      key = "18341"
      date = "101010"
      shift_hash = @cypher.shift_numbers(key, date)
    assert_equal ({encryption: "zrcnsulnpra?", key: "18341", date: "101010"}),
    @cypher.encrypt("how are you?", key, date, shift_hash)
  end
end
