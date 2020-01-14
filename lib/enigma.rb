require_relative '../lib/shift'

class Enigma

  def initialize
    @shift = Shift.new
  end

  def encrypt(message, key = "0", date = "today")
    key = @shift.key_check(key)
    date = @shift.date_check(date)
    shift_hash= @shift.shift_numbers(key, date)
    @shift.encrypt(message, key, date, shift_hash)
  end

  def decrypt(ciphertext, key, date = "today")
    message = ciphertext
    date = @shift.date_check(date)
    shift_hash= @shift.shift_numbers(key, date)
    @shift.decrypt(message, key, date, shift_hash)
  end
end
