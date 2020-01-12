require 'time'
require 'pry'

class Shift
  attr_reader :date, :key

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
end

  #     elsif letter_or_space =~ /[a-z ]
  #       key_counter += 1
  #       character = letter_or_space
  #     else
  #       key_counter += 1
  #       change = letter_or_space.ord + shift_hash[key_counter]
  #       changed = change_counter(change)
  #     end
  #   end
  # end
  #
  # def change_counter(change)
  #   until change < 123
  #     change -= 26
  #   end
  #   change
  # end



  # def encrypt(message, key, date)
  #   shift_hash = shift_numbers(key, date)
  #   message_to_encrypt = message.downcase.chars
  #
  #   encrypted_message = message_to_encrypt.map do |letter|
  #     letter.ord
  #
  #

    #.ord and .chr
