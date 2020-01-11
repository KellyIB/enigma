require 'time'
require 'pry'

class Shift
  attr_reader :key, :date

  def initialize
    @key = nil
    @date = "today"
  end

  def current_date(date = "today")
    @date = Time.now.strftime('%d/%m/%y')
  end

  def random_key
    @key = rand(99999)
  end

end
