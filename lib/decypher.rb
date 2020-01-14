require 'pry'

class Decypher < Shift

  def initialize
  end

  def decrypt(message, key, date, shift_hash)
    {decryption: unchange_message(message, shift_hash), key: key, date: date}
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
      character_choice(letter_or_space, shift_hash, key_counter, decrypt_shift)
    end
    shifted_message.join
  end

  def character_choice(letter_or_space, shift_hash, key_counter, decrypt_shift)
    if ((letter_or_space.match(/^[[:alpha:][:blank:]]+$/)) == nil) || (
      (shift_hash[key_counter].to_i) % 27 == 0)
      letter_or_space
    elsif (alphabet_and_space_array.index(letter_or_space)) >= decrypt_shift
        alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) - decrypt_shift)]
    else
      alphabet_and_space_array[(alphabet_and_space_array.index(letter_or_space) - (decrypt_shift - 27)).abs]
    end
  end



end
