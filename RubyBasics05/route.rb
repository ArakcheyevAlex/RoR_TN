class Route
  attr_reader :stations_list, :name

  def self.find_by_name(name)
    @@routes.each do |route| 
      return route if route.name == name
    end
    nil
  end

  def initialize(name, first_station, last_station)
    @name = name
    @stations_list = [first_station, last_station]
    @@routes << self
  end

  def add_station(station)
    @stations_list.insert(-2, station) unless @stations_list.include?(station)
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

    @stations_list[@stations_list.index(station) + 1]
  end

  def previous_station(station)
    return station if station == @stations_list.first

    @stations_list[@stations_list.index(station) - 1]
  end

  def description
    "Name: #{name}, from: #{@stations_list.first.name}, to: #{@stations_list.last.name}"
  end

  protected
  
  @@routes = []

end
