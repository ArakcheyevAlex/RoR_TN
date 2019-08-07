sides = []

puts "Enter the length of the first side:"
sides.push(gets.chomp.to_f)

puts "Enter the length of the second side:"
sides.push(gets.chomp.to_f)

puts "Enter the length of the third side:"
sides.push(gets.chomp.to_f)

if sides[0] == sides[1] && sides[0] == sides[2]
  kind_of_triangle = "Isosceles and Equilateral"
elsif sides[0] == sides[1] || sides[0] == sides[2] || sides[1] == sides[2]
  kind_of_triangle = "Isosceles"
else
  cathet1, cathet2, hypotenuse = sides.sort
  if (hypotenuse**2 - (cathet1**2 + cathet2**2)).abs < 0.00001
    if cathet1 == cathet2 
      kind_of_triangle = "Right and Isosceles"
    else
      kind_of_triangle = "Right"
    end
  else
    kind_of_triangle = "not Isosceles, Equilateral or Right"
  end
end

puts "Triangle is #{kind_of_triangle}"

