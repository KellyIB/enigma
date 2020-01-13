require_relative '../test/test_helper'
require_relative '../lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_is_an_instance_of
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_encrypt
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}),
    @enigma.encrypt("hello world", "02715", "040895")
    assert_equal ({:encryption=>"nibzu mcxpu", :key=>"02715", :date=>"120120"}),
    @enigma.encrypt("hello world", "02715", "120120")
  end

  def test_it_can_decrypt
    assert_equal ({decryption: "hello world", key: "02715", date: "040895"}),
    @enigma.decrypt("keder ohulw", "02715", "040895")
  end
end





 #    game_path = './data/games_dummy.csv'
 #    team_path = './data/teams.csv'
 #    game_teams_path = './data/game_teams_dummy.csv'
 #
 #    our_locations = {
 #      games: game_path,
 #      teams: team_path,
 #      game_teams: game_teams_path
 #    }
 #
 # end
