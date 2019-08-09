shopping_cart = {}

loop do
  puts "Enter product name or  \"stop\""
  product_name = gets.chomp

  next if product_name.empty?
  
  break if product_name == "stop"

  if shopping_cart[product_name]
    puts "Product #{product_name} already in the cart. Enter quantity to add:"
    quantity = gets.chomp.to_f

    shopping_cart[product_name][:quantity] += quantity
  else    
    puts "Enter price for #{product_name}:"
    price = gets.chomp.to_f

    puts "Enter quantity:"
    quantity = gets.chomp.to_f

    shopping_cart[product_name] = {price: price, quantity: quantity}
  end
end

total = 0

shopping_cart.each do |product_name, details|
  pos_total = details[:price] * details[:quantity]
  total += pos_total
  
  puts "#{product_name.to_s}:: #{details[:price]} * #{details[:quantity]} == #{pos_total}"
end

puts "TOTAL: #{total}" 
