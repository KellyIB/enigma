require 'time'
require_relative '../lib/enigma'

class Shift
  attr_reader :key, :date

  def initialize(key = "random_key", date = "today")
    @key = "random_key"
    @date = "today"
  end

end
