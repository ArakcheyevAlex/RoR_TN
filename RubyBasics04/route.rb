class Route
  attr_reader :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]    
  end

  def add_station(station)
    @stations_list.insert(-2, station) if !@stations_list.include?(station)
  end

  def delete_station(station)
    if @stations_list.first == station || @stations_list.last == station
      puts "Can't delete first or last station in the route"
    else
      @stations_list.delete(station)
    end
  end

  def show_stations_list
    @stations_list.each do |station|
      puts "#{stations_list.index(station) + 1}. #{station.name}"
    end
  end

  def next_station(station)
    return station if station == @stations_list.last

    return @stations_list[@stations_list.index(station) + 1]
  end

  def previous_station(station)
    return station if station == @stations_list.first

    return @stations_list[@stations_list.index(station) - 1]
  end





end
