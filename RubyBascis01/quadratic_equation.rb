puts "Roost of Quadratic equation (ax** + bx + c = 0)"

puts "Enter coefficient a:"
a = gets.chomp.to_f

puts "Enter coefficient a:"
b = gets.chomp.to_f

puts "Enter coefficient c:"
c = gets.chomp.to_f

discriminant = b**2 - (4 * a * c)

puts "#{a}xˆ2 + #{b}x + #{c} = 0"

if discriminant < 0
  puts "D = #{discriminant}. Equation have no roots"
elsif discriminant == 0
  root = -b / (2 * a)
  puts "D = #{discriminant}. Equation's root is #{x}"
else
  discriminant_sqrt = Math.sqrt(discriminant)
  root1 = (-b + discriminant_sqrt) / (2 * a)
  root2 = (-b - discriminant_sqrt) / (2 * a)
  puts "D = #{discriminant_sqrt}. Equation's roots are #{root1} and #{root2}"
end
