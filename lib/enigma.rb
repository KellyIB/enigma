require_relative '../lib/shift'
require_relative '../lib/cypher'

class Enigma

  def initialize
    @shift = Shift.new
    @cypher = Cypher.new
    @decypher = Decypher.new
  end

  def encrypt(message, key = "0", date = "today")
    key = @shift.key_check(key)
    date = @shift.date_check(date)
    shift_hash= @shift.shift_numbers(key, date)
    @cypher.encrypt(message, key, date, shift_hash)
  end

  def decrypt(ciphertext, key, date = "today")
    message = ciphertext
    date = @shift.date_check(date)
    shift_hash= @shift.shift_numbers(key, date)
    @decypher.decrypt(message, key, date, shift_hash)
  end
end
