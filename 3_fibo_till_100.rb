fibonacci_numbers = [0,1]

loop do  
  next_number = fibonacci_numbers[-1] + fibonacci_numbers[-2]
  if next_number > 100
    break
  end
  fibonacci_numbers << next_number
end

puts fibonacci_numbers
