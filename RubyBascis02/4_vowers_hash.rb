vowers = {}

alphabet = ('a'..'z').to_a

alphabet.each do |letter|
  if letter =~ /[aeiou]/ 
    vowers[letter] = alphabet.index(letter) + 1
  end
end

puts vowers
