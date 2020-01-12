require 'time'
require 'pry'

class Shift
  attr_reader :date, :key

  def initialize
  end

  def key_check(key)
    if key == "0"
      key = rand(100000).to_s.rjust(5,'0')
    end
    key
  end

  def date_check(date)
    if date == "today"
      date = Time.now.strftime('%d%m%y')
    end
    date
  end

  def keys_maker(key)
    key_start = key.chars
    key_numbers = [1, 2, 3, 4]
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

  def key_counter_check(key_counter)
    if key_counter == 4
      key_counter = 1
    else
      key_counter += 1
    end
    key_counter
  end

  def broken_message(message)
     message.downcase.chars
  end

  def index_checker(index_check)
    times = (index_check.abs / 27)
      if index_check >= 26
        index_check -= 27 * (times)
      elsif index_check < 0 && index_check < -27
        index_check -= 27 * (times)

      end
    index_check
  end

  def change_message(message, shift_hash)
    key_counter = 0
    shifted_message = (broken_message(message)).map do |letter_or_space|
      key_counter = key_counter_check(key_counter)
      if ((letter_or_space.match(/^[[:alpha:][:blank:]]+$/)) == nil) || ((shift_hash[key_counter].to_i) % 27 == 0) || letter_or_space == " "
        letter_or_space
      elsif (alphabet_and_space_array.index(letter_or_space) + shift_hash[key_counter]).abs <= 26
        alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) + shift_hash[key_counter]).abs]
      else
        alphabet_and_space_array[index_checker(alphabet_and_space_array.index(letter_or_space) + shift_hash[key_counter]).abs]
      end
    end
    shifted_message.join
  end

  # def unchange_message(message, shift_hash)
  #   key_counter = 0
  #   shifted_message = (broken_message(message)).map do |letter_or_space|
  #     key_counter = key_counter_check(key_counter)
  #     if ((letter_or_space.match(/^[[:alpha:][:blank:]]+$/)) == nil) || ((shift_hash[key_counter].to_i) % 27 == 0) || letter_or_space == " "
  #       letter_or_space
  #     elsif (alphabet_and_space_array.index(letter_or_space) + shift_hash[key_counter]) <= 26
  #       alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) + shift_hash[key_counter])]
  #     else
  #       alphabet_and_space_array[index_checker(alphabet_and_space_array.index(letter_or_space) + shift_hash[key_counter])]
  #     end
  #   end
  #   shifted_message.join
  # end

  def encrypt(message, key, date, shift_hash)
    {encryption: change_message(message, shift_hash), key: key, date: date}
  end

  # def random_key
  #   @key = rand(100000).to_s
  # end


end
