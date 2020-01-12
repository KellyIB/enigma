require_relative '../test/test_helper'
require_relative '../lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_is_an_instance_of
    assert_instance_of Enigma, @enigma
  end
  #
  # def test_it_changes_date_instance_variables_if_needed
  # @enigma.encrypt("The eagle has landed.", key = "0", date = "today")
  #   assert_equal (Time.now.strftime('%d%m%y')), @enigma.date
  # end

  def test_it_can_find_the_shift_keys
    assert_equal ({}), @enigma.shift_hash
    @enigma.encrypt("The eagle has landed.", key = "12345", date = "today")
    assert_equal ({1=>16, 2=>27, 3=>34, 4=>45}), @enigma.shift_hash
  end

  def test_it_can_encrypt
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}),
    @enigma.encrypt("hello world", "02715", "040895")
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
