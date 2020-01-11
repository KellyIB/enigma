require_relative '../test/test_helper'
require_relative '../lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_is_an_instance_of
    assert_instance_of Enigma, @enigma
  end

  def test_it_changes_date_instance_variables_if_needed
    @enigma.encrypt("The eagle has landed.", key = nil, date = "today")
    assert_equal (Time.now.strftime('%d/%m/%y')), @enigma.date
    refute_nil @enigma.key
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
