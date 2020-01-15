module Assistable

  def abc_array
    ('a'..'z').to_a << " "
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
