class Train
  attr_reader :number, :type, :speed, :wagons, :current_station, :route

  def self.find_by_number(number)
    @@trains.each do |train| 
      return train if train.number == number
    end
    nil
  end

  def initialize(number, type)
    if type != :cargo && type != :passenger 
      raise ArgumentError.new("Type must be only :cargo or :passenger") 
    end

    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @@trains << self
  end

  def speed_up(value = 100)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def stopped?
    @speed == 0
  end

  def wagons_count
    @wagons.count
  end

  def drop_wagons
    @wagons = []
  end

  def add_wagon(wagon)
    raise ArgumentError.new('Incorrect wagon type') unless wagon.type == @type

    @wagons << wagon if stopped? && !@wagons.include?(wagon)
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon)    
  end

  def set_route(route)
    @current_station.remove_train(self) if @current_station
    @route = route
    @current_station = @route.stations_list.first
    @current_station.receive_train(self)
  end

  def has_route?
    !@route.nil?
  end

  def next_station
    @route.next_station(@current_station)
  end

  def previous_station
    @route.previous_station(@current_station)
  end

  def go_to_next_station
    go_to_station(next_station)
  end

  def go_to_previous_station
    go_to_station(previous_station)
  end

  protected
  # go_to_station в protected чтобы нельзя было поместить поезд на произвольную станцию

  def go_to_station(station)
    if station != @current_station 
      @current_station.remove_train(self)
      @current_station = station
      @current_station.receive_train(self)
    end
  end

  @@trains = []

end
