require_relative '../test/test_helper'
require_relative '../lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new("The eagle has landed.", key = "key", date = "today")
  end

  def test_is_an_instance_of
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_equal ("The eagle has landed."), @enigma.message
    assert_equal ("key"), @enigma.key
    assert_equal ("today"), @enigma.date
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
