def leap_year?(year)
  (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
end

days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Enter year:"
year = gets.chomp.to_i

puts "Enter month:"
month = gets.chomp.to_i

puts "Enter day:"
day = gets.chomp.to_i

number_of_days[1] = 29 if leap_year?(year)

day_index = days_per_month.take(month - 1).sum + day

puts "Day number in the year: #{day_index}"
