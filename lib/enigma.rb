require_relative '../lib/shift'

class Enigma
  attr_reader :message, :date, :shift_hash
  attr_accessor :key

  def initialize
    @message = message
    @key = "0"
    @date = "today"
    @shift = Shift.new
    @shift_hash = {}
  end

  def key_check(key)
    if key == "0"
      @key = @shift.random_key
    else
      @key = key
    end
    @key
  end

  def encrypt(message, key = "0", date = "today")
    key = key_check(key)
    if date == "today"
      @date = @shift.current_date(date)
      date = @date
    end
     @shift_hash= @shift.shift_numbers(key, date)
     @shift.encrypt(message, key, date, @shift_hash)
  end
end
 # The encrypt method takes a message String as an argument. It can optionally
# take a Key and Date as arguments to use for encryption. If the key is not included,
# generate a random key. If the date is not included, use today’s date.
#
# The encrypt method returns a hash with three keys:
#
# :encryption => the encrypted String
# :key => the key used for encryption as a String
# :date => the date used for encryption as a String in the form DDMMYY

  # def decrypt(ciphertext, key, date = "today")
#
# The decrypt method takes a ciphertext String and the Key used for encryption as arguments. The decrypt method can optionally take a date as the third argument. If no date is given, this method should use today’s date for decryption.
#
# The decrypt method returns a hash with three keys:
#
# :decryption => the decrypted String
# :key => the key used for decryption as a String
# :date => the date used for decryption as a String in the form DDMMYY
  # end
