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
#
# The decrypt method takes a ciphertext String and the Key used for encryption as arguments. The decrypt method can optionally take a date as the third argument. If no date is given, this method should use today’s date for decryption.
#
# The decrypt method returns a hash with three keys:
#
# :decryption => the decrypted String
# :key => the key used for decryption as a String
# :date => the date used for decryption as a String in the form DDMMYY
  # end
