require './station'
require './train'
require './cargo_train'
require './passenger_train'
require './route'
require './wagon'

def print_separator
  40.times {print '-'}
  print "\n"
end

def show_main_menu
  print_separator
  puts "What do you want to do? (enter the number):"
  print_separator

  puts "1. Create station"
  puts "2. Create train"
  puts "3. Manage routes"
  puts "4. Set route to train"
  puts "5. Add wagons to train"
  puts "6. Remove wagons from train"
  puts "7. Move train to next or previous station"
  puts "8. Show stations list"
  puts "9. Show trains on the station"
  puts "0. Exit"
  print_separator
end

def choose_station(prefix = '')
  puts "Enter #{prefix} station name:"
  station_name = gets.chomp.to_s
  
  if station_name.empty? 
    puts "Station name is incorrect"
    return nil
  end
  
  station = Station.find_by_name(station_name)
  
  puts "Station '#{station_name}' not found" unless station
  
  [station, station_name]
end

def choose_route
  puts "Enter route name:"
  route_name = gets.chomp.to_s
  
  if route_name.empty? 
    puts "ERROR: Route name is incorrect"
    return nil, route_name
  end

  route = Route.find_by_name(route_name)

  puts "Route '#{route_name}' not found" unless route

  [route, route_name]
end

def choose_train
  puts "Enter train number:"
  train_number = gets.chomp.to_s
  
  if train_number.empty? 
    puts "ERROR: Train number is incorrect"
    return
  end

  train = Train.find_by_number(train_number)

  puts "Train #{train_number} not found" unless train

  [train, train_number]
end

def create_station
  station, station_name = choose_station
  
  if station
    puts "Station '#{station_name}'' already exists"
    return
  end

  Station.new(station_name)
  puts "Station '#{station_name}' was created"
end

def create_train
  train, train_number = choose_train

  if train
    puts "Train #{train_number} already exists"
    return
  end

  puts "Enter trains type ('passenger' OR 'cargo'):"
  type = gets.chomp.to_sym

  case type
  when :passenger
    PassengerTrain.new(train_number)
    puts "Train '#{train_number}' was created"
  when :cargo
    CargoTrain.new(train_number)
    puts "Train '#{train_number}' was created"
  else
    puts "ERROR: Incorrect train type"
  end
end

def manage_routes
  puts "What do you want to do with routes? (enter the number):"

  puts "1. Add route"
  puts "2. Add station to route"
  puts "3. Remove station from route"

  action = gets.chomp.to_i
  case action
  when 1
    route, route_name = choose_route
    
    if route
      puts "Route '#{route_name}' already exists"
      return
    end

    first_station, _ = choose_station('first')
    return unless first_station
    last_station, _ = choose_station('last')
    return unless last_station
    
    Route.new(route_name, first_station, last_station)
    puts "Route '#{route_name}' was created"
  when 2
    route, route_name = choose_route

    return unless route
    
    station, station_name = choose_station()
    return unless station
    
    if route.stations_list.include?(station)
      puts "Station '#{station_name}' already exist in the route '#{route_name}'"
      return
    end

    route.add_station(station)
    puts "Station '#{station_name}' was added to route '#{route_name}'"
  when 3
    route, route_name = choose_route

    return unless route
    
    station, station_name = choose_station()
    return unless station

    unless route.stations_list.include?(station)
      puts "Station '#{station_name}' not found in route '#{route_name}'"
      return
    end

    if route.stations_list.first == station || route.stations_list.last == station
      puts "Station '#{station_name}' is first or last in route '#{route_name}'. Remove is impossible."
      return
    end

    route.delete_station(station)
  end
end

def set_route_to_train
  route, route_name = choose_route
  return unless route
  
  train, train_number = choose_train
  return unless train

  train.set_route(route)
  puts "Set route '#{route_name}' for train '#{train_number}'."  
end

def add_wagon
  train, train_number = choose_train
  return unless train
  
  new_wagon = Wagon.new(train.type)
  train.add_wagon(new_wagon)
  puts "Wagon number #{new_wagon.number} was added to train #{train_number}" 
end

def remove_wagon
  train, train_number = choose_train
  return unless train

  if train.wagons.empty? 
    puts "Train #{train_number} has no wagons"
    return
  end

  wagon_to_remove = train.wagons.last
  train.remove_wagon(train.wagons.last)
  puts "Wagon number #{wagon_to_remove.number} type #{wagon_to_remove.type} was removed from train #{train_number}"
end

def move_train
  train, train_number = choose_train
  return unless train
  
  unless train.has_route?
    puts "Train #{train_number} has no route"
    return    
  end  
  
  puts "Train #{train_number} is now on the #{train.current_station.name}"
  puts "Enter train's direction ('next' or 'previous'):"
  
  direction = gets.chomp.to_sym
  
  case direction
  when :next
    if train.next_station == train.current_station
      puts "Train is already on the last station"
      return
    end

    train.go_to_next_station
    puts "Going to the #{train.current_station.name}"
  when :previous
    if train.previous_station == train.current_station
      puts "Train is already on the first station"
      return
    end

    train.go_to_previous_station
    puts "Going to the #{train.current_station.name}"
  end
end

def show_stations_list
  if Station.stations_list.empty?
    puts "No stations found"
    return
  end

  puts "Stations list:"
  print_separator
  
  Station.stations_list.each {|station_name, stations| puts station_name}
end

def show_trains_on_station
  station, _ = choose_station
  return unless station

  if station.trains.empty?
    puts "No trains found in #{station.name}"
    return
  end

  puts "Trains on station #{station.name}:"
  print_separator
  
  station.trains.each do |train| 
    route_description = train.has_route? ? train.route.description : 'Unknown'
    puts "Train number #{train.number} (Route #{route_description})"
  end
end

loop do
  show_main_menu

  command = gets.chomp.to_i

  case command
  when 1
    create_station
  when 2
    create_train
  when 3
    manage_routes
  when 4
    set_route_to_train
  when 5
    add_wagon
  when 6
    remove_wagon
  when 7
    move_train
  when 8
    show_stations_list
  when 9
    show_trains_on_station
  when 0
    break
  else
    next
  end
end
