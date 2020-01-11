require 'time'
require_relative '../lib/enigma'

class Shift
  attr_reader :key, :date

  def initialize(key = "random_key", date = "today")
    @key = "random_key"
    @date = "today"
  end

  def current_date(date)
    if date = "today"
    @date = Time.now.strftime('%d/%m/%y')
    end
  end

end
