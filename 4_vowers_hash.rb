vowers = {}

alphabet = 'a'.upto('z').to_a

alphabet.each { |letter|
  if letter =~ /[aeiou]/ 
    vowers[letter] = alphabet.index(letter) + 1
  end
}

puts vowers
