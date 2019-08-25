class UserInterface
  def print_separator
    40.times { print '-' }
    print "\n"
  end

  def double_separator
    print_separator
    yield
    print_separator
  end

  def show_main_menu
    double_separator { puts 'What do you want to do? (enter the number):' }

    puts '1. Create station'
    puts '2. Create train'
    puts '3. Manage routes'
    puts '4. Set route to train'
    puts '5. Add wagons to train'
    puts '6. Remove wagons from train'
    puts '7. Move train to next or previous station'
    puts '8. Show stations list'
    puts '9. Show trains on the station'
    puts '10. Show train`s wagons list'
    puts '11. Load wagon'
    puts '0. Exit'

    print_separator
  end

  def choose_station(prefix = '')
    puts "Enter #{prefix} station name:"
    station_name = gets.chomp.to_s

    if station_name.empty?
      puts 'Station name is incorrect'
      return nil
    end

    station = Station.find_by_name(station_name)

    puts "Station '#{station_name}' not found" unless station

    [station, station_name]
  end

  def choose_route
    puts 'Enter route name:'
    route_name = gets.chomp.to_s

    if route_name.empty?
      puts 'ERROR: Route name is incorrect'
      return nil, route_name
    end

    route = Route.find_by_name(route_name)

    puts "Route '#{route_name}' not found" unless route

    [route, route_name]
  end

  def choose_train
    puts 'Enter train number:'
    train_number = gets.chomp.to_s

    if train_number.empty?
      puts 'ERROR: Train number is incorrect'
      return
    end

    train = Train.find_by_number(train_number)

    puts "Train #{train_number} not found" unless train

    [train, train_number]
  end

  def choose_wagon
    puts 'Enter wagon number:'
    wagon_number = gets.chomp.to_s

    if wagon_number.empty?
      puts 'ERROR: Wagon number is incorrect'
      return
    end

    wagon = Wagon.find_by_number(wagon_number)

    puts "Wagon #{wagon_number} not found" unless wagon

    [wagon, wagon_number]
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
      new_train = PassengerTrain.new(train_number)
    when :cargo
      new_train = CargoTrain.new(train_number)
    else
      raise ArgumentError, 'Incorrect train type'
    end

    puts "Train '#{train_number}' was created" if new_train.valid?
  rescue ArgumentError => e
    puts "Error while train creation: #{e.message}"

    retry
  end

  def manage_routes
    puts 'What do you want to do with routes? (enter the number):'

    puts '1. Add route'
    puts '2. Add station to route'
    puts '3. Remove station from route'

    action = gets.chomp.to_i
    case action
    when 1
      route, route_name = choose_route

      if route
        puts "Route '#{route_name}' already exists"
        return
      end

      first_station, = choose_station('first')
      return unless first_station

      last_station, = choose_station('last')
      return unless last_station

      Route.new(route_name, first_station, last_station)
      puts "Route '#{route_name}' was created"
    when 2
      route, route_name = choose_route

      return unless route

      station, station_name = choose_station
      return unless station

      if route.stations_list.include?(station)
        puts "'#{station_name}' already exist in the route '#{route_name}'"
        return
      end

      route.add_station(station)
      puts "Station '#{station_name}' was added to route '#{route_name}'"
    when 3
      route, route_name = choose_route

      return unless route

      station, station_name = choose_station
      return unless station

      unless route.stations_list.include?(station)
        puts "'#{station_name}' not found in route '#{route_name}'"
        return
      end

      if [route.stations_list.first, route.stations_list.last].include?(station)
        puts "'#{station_name}' is first or last in route '#{route_name}'."
        puts 'Remove is impossible.'
        return
      end

      route.delete_station(station)
    end
  end

  def assign_route_to_train
    route, route_name = choose_route
    return unless route

    train, train_number = choose_train
    return unless train

    train.assign_route(route)
    puts "Assign route '#{route_name}' for train '#{train_number}'."
  end

  def add_wagon
    train, train_number = choose_train
    return unless train

    puts 'Enter wagon`s capacity'
    capacity = gets.chomp.to_i
    if capacity <= 0
      puts 'Invalid capacity'
      return
    end

    if train.type == :cargo
      new_wagon = CargoWagon.new(capacity)
    elsif train.type == :passenger
      new_wagon = PassengerWagon.new(capacity)
    else
      puts 'Incorrect train type'
      return
    end

    train.add_wagon(new_wagon)
    puts "Wagon №#{new_wagon.number} (cap: #{new_wagon.capacity},"
    puts "type: #{new_wagon.type}) created"
    puts "Wagon №#{new_wagon.number} was added to train #{train_number}"
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
    puts "Wagon number #{wagon_to_remove.number} type #{wagon_to_remove.type}"
    puts "was removed from train #{train_number}"
  end

  def move_train
    train, train_number = choose_train
    return unless train

    unless train.route?
      puts "Train #{train_number} has no route"
      return
    end

    puts "Train #{train_number} is now on the #{train.current_station.name}"
    puts "Enter train's direction ('next' or 'previous'):"

    direction = gets.chomp.to_sym

    case direction
    when :next
      if train.next_station == train.current_station
        puts 'Train is already on the last station'
        return
      end

      train.go_to_next_station
    when :previous
      if train.previous_station == train.current_station
        puts 'Train is already on the first station'
        return
      end

      train.go_to_previous_station
    else
      return
    end

    puts "Going to the #{train.current_station.name}"
  end

  def show_stations_list
    if Station.stations_list.empty?
      puts 'No stations found'
      return
    end

    puts 'Stations list:'
    print_separator

    Station.stations_list.each { |station_name, _station| puts station_name }
  end

  def show_trains_on_station
    station, = choose_station
    return unless station

    if station.trains.empty?
      puts "No trains found in #{station.name}"
      return
    end

    double_separator { puts "Trains on station #{station.name}:" }
    station.trains_each { |train| puts train.short_description }
  end

  def show_train_wagons_list
    train, = choose_train
    return unless train

    double_separator { puts train.description }
    train.wagons_each { |wagon| puts wagon.description }
  end

  def load_wagon
    wagon, = choose_wagon
    return unless wagon

    puts wagon.description

    if wagon.type == :passenger
      wagon.take_place
    elsif wagon.type == :cargo
      puts 'Enter value to load'
      value = gets.chomp.to_i
      wagon.load_wagon(value)
    else
      puts 'ERROR: Incorrect wagon type'
      return
    end

    puts 'Wagon loaded.'
    puts wagon.description
  end

  def run
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
        assign_route_to_train
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
      when 10
        show_train_wagons_list
      when 11
        load_wagon
      when 0
        break
      else
        next
      end
    end
  end
end
