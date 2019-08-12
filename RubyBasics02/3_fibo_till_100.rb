fibonacci_numbers = [0,1]

while (next_number = fibonacci_numbers[-1] + fibonacci_numbers[-2]) < 100 do
  fibonacci_numbers << next_number
end

puts fibonacci_numbers
