puts "Enter your name:"
name = gets.chomp

puts "Enter your height:"
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight >= 0 
  puts "#{name}, your ideal weight is #{ideal_weight}"
else
  puts "#{name}, you weight is ideal already"
end
