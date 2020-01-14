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

  def abc_array
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

  def special_character_check(letter)
    letter.match(/^[[:alpha:][:blank:]]+$/)
  end

end
