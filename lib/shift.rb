require 'time'
require 'pry'

class Shift
  attr_reader :date, :key

  # @@alphabet_and_space_array = []

  # def self.alpha_array
  #   array = ('a'..'z').to_a
  #   array.unshift(" ")
  #   array
  # end
  #
  def initialize
    @key = "0"
    @date = "today"
  end

  def current_date(date = "today")
    @date = Time.now.strftime('%d%m%y')
  end

  def random_key
    @key = rand(100000).to_s
  end

  def keys_maker(key)
    key_numbers = [1, 2, 3, 4]
    key_start = key.chars
    key_counter = 0
    key_numbers.reduce ({}) do |acc, key_number|
      acc[key_number] = (key_start[key_counter] + key_start[key_counter + 1]).to_i
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
    keys.reduce ({}) do |acc, (key_number, number)|
      acc[key_number] = number + ((offset[offset_counter]).to_i)
      offset_counter += 1
      acc
    end
  end

  def alphabet_and_space_array
    array = ('a'..'z').to_a
    array.unshift(" ")
    array
  end

  def change_message(message, shift_hash)
    space_and_alphabet = alphabet_and_space_array
    key_counter = 1
    shifted_message = (broken_message(message)).map do |letter_or_space|
      if ((letter_or_space.match(/^[[:alpha:][:blank:]]+$/)) == nil) || ((shift_hash[key_counter]) % 27 == 0)
        letter_or_space
      elsif (space_and_alphabet.index(letter_or_space) + shift_hash[key_counter]) <= 26
        space_and_alphabet[(space_and_alphabet.index(letter_or_space) + shift_hash[key_counter])]
      else
        space_and_alphabet[index_checker(space_and_alphabet.index(letter_or_space))]
      end
    end
    key_counter_check(key_counter)
    shifted_message
  end

  def key_counter_check(key_counter)
    if key_counter == 5
      key_counter = 1
    else
      key_counter += 1
    end
  end

  def broken_message(message)
     message.downcase.chars
  end

  def index_checker(index_check)
    if index_check > 26
      loop do
       index_check -= 27
       if index_check >=26
         break
       end
      end
    end
    index_check
  end
end
