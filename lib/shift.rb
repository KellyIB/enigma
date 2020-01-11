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
    @key = rand(100000).to_s
  end

  def keys_maker(key)
    key_letters = ["a", "b", "c", "d"]
    key_start = key.chars
    key_counter = 0
    key_letters.reduce ({}) do |acc, letter|
      acc[letter] = (key_start[key_counter] + key_start[key_counter + 1]).to_i
      key_counter += 1
      acc
    end
  end

  end
