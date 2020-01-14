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
    shifted_message = (message.downcase.chars).map do |letter_or_space|
    key_counter = key_counter_check(key_counter)
    cyphered_character(letter_or_space, key_counter, shift_hash)
    end
    shifted_message.join
  end

  def cyphered_character(letter_or_space, key_counter, shift_hash)
    if ((letter_or_space.match(/^[[:alpha:][:blank:]]+$/)) == nil) || (
      (shift_hash[key_counter].to_i) % 27 == 0)
      letter_or_space
    elsif ((('a'..'z').to_a << " ").index(letter_or_space) +(shift_hash[key_counter])) <= 26
      alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) +
      shift_hash[key_counter])]
    else
      alphabet_and_space_array[index_checker(alphabet_and_space_array.index(
      letter_or_space) + shift_hash[key_counter])]
    end
  end
end
