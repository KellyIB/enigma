require 'date'

class Shift

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
      date = Date.today.strftime('%d%m%y')
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
    offset = offset_maker(date)
    offset_counter = 0
    (keys_maker(key)).reduce ({}) do |acc, (key_number, number)|
      acc[key_number] = number + ((offset[offset_counter]).to_i)
      offset_counter += 1
      acc
    end
  end

  def alphabet_and_space_array
    (('a'..'z').to_a << " ")
  end

  def key_counter_check(key_counter)
    if key_counter == 4
      key_counter = 1
    else
      key_counter += 1
    end
    key_counter
  end

  def index_checker(index_check)
    times = (index_check.abs / 27).to_i
      index_check -= (27 * times)
  end

  def change_message(message, shift_hash)
    key_counter = 0
    shifted_message = (message.downcase.chars).map do |letter_or_space|
    key_counter = key_counter_check(key_counter)
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
    shifted_message.join
  end

  def adjust_number(ciphertext_index, shift_number)
    return shift_number if ciphertext_index == nil
    if shift_number > ciphertext_index
      times = (shift_number / 27).to_i
      shift_number = shift_number - (27 * times)
    end
    shift_number
  end

  def unchange_message(message, shift_hash)
    key_counter = 0
    shifted_message = (message.downcase.chars).map do |letter_or_space|
      key_counter = key_counter_check(key_counter)
      decrypt_shift = adjust_number(alphabet_and_space_array.index(letter_or_space), shift_hash[key_counter])
      #rf
      if ((letter_or_space.match(/^[[:alpha:][:blank:]]+$/)) == nil) || (
        (shift_hash[key_counter].to_i) % 27 == 0)
        letter_or_space
      elsif (alphabet_and_space_array.index(letter_or_space)) >= decrypt_shift
          alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) - decrypt_shift)]
      else
        alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) - (decrypt_shift - 27)).abs]
      end
    end
    shifted_message.join
  end

    def encrypt(message, key, date, shift_hash)
      {encryption: change_message(message, shift_hash), key: key, date: date}
    end

    def decrypt(message, key, date, shift_hash)
      {decryption: unchange_message(message, shift_hash), key: key, date: date}
    end
end
