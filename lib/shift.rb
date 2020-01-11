require 'time'
require 'pry'

class Shift
  attr_reader :date, :key

  def initialize
    @key = nil
    @date = "today"
  end

  def current_date(date = "today")
    @date = Time.now.strftime('%d/%m/%y')
  end

  def random_key
    @key = rand(100000).to_s
  end

  def keys_maker(key)
    key_letters = ["a", "b", "c", "d"]
    key_start = key.chars
    key_counter = 0
    key_letters.reduce ({}) do |acc, letter|
      acc[letter] = (key_start.at(key_counter) + key_start.at(key_counter + 1)).to_i
      key_counter += 1
      acc
    end
  end

  def offset_maker(date)
    date_square = (((date.to_f) ** 2).to_i).to_s
    (date_square.slice(-4..-1)).chars
  end

  def shift_numbers(key, date)
    keys = keys_maker(key)
    offset = offset_maker(date)
    offset_counter = 0
    keys.reduce ({}) do |acc, (letter, number)|
      acc[letter] = number + ((offset[offset_counter]).to_i)
      offset_counter += 1
      acc
    end
  end
end
