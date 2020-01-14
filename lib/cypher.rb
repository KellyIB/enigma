require 'pry'

class Cypher < Shift

  def initialize
  end

  def encrypt(message, key, date, shift_hash)
    {encryption: change_message(message, shift_hash), key: key, date: date}
  end

  def index_checker(index_check)
    times = (index_check.abs / 27).to_i
    index_check -= (27 * times)
  end

  def change_message(message, shift_hash)
    key_counter = 0
    shifted_message = (message.downcase.chars).map do |letter|
    key_counter = key_counter_check(key_counter)
    cyphered_character(letter, key_counter, shift_hash)
    end
    shifted_message.join
  end

  def cyphered_character(letter, key_counter, shift_hash)
    if special_character_check(letter) == nil || shift_hash[key_counter].to_i % 27 == 0
      letter
    elsif (abc_array.index(letter) + shift_hash[key_counter]) <= 26
      abc_array[(abc_array.index(letter) + shift_hash[key_counter])]
    else
      abc_array[index_checker(abc_array.index(letter) + shift_hash[key_counter])]
    end
  end
end
