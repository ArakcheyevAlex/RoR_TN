class Train
  attr_reader :number, :type, :speed, :wagons_count, :current_station

  def initialize(number, type, wagons_count = 10)
    if type != :cargo && type != :passengers 
      raise ArgumentError.new("Type must be only :cargo or :passengers") 
    end

    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
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

  def add_wagon
    @wagons_count += 1 if stopped?
  end

  def remove_wagon
    @wagons_count -= 1 if stopped? && wagons_count > 0
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations_list.first
    @current_station.receive_train(self)
  end

  def next_station
    @route.next_station(@current_station)
  end

  def previous_station
    @route.previous_station(@current_station)
  end

  def go_to_station(station)
    if station != @current_station
      @current_station.remove_train(self)
      @current_station = station
      @current_station.receive_train(self)
    end
  end

  def go_to_next_station
    go_to_station(next_station)
  end

  def go_to_previous_station
    go_to_station(previous_station)
  end
end
