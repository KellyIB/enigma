require_relative '../lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close

decrypted_message = enigma.decrypt(message, key = ARGV[2], date = ARGV[3])

puts "Created #{decrypted_message[:decryption]} with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}."

writer = File.open(ARGV[1], "w")

writer.write(decrypted_message[:decryption])

writer.close
