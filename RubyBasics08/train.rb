require './manufacturer'
require './validator'

class Train
  include Manufacturer
  include Validator

  TRAIN_TYPES = [:cargo, :passenger]
  NUMBER_FORMAT = /^[a-z|\d]{3}-?[a-z|\d]{2}$/i
  
  attr_reader :number, :type, :speed, :wagons, :current_station, :route

  class << self

    def find_by_number(number)
      @@trains[number]
    end
  
    alias_method :find, :find_by_number
  end  

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    @@trains[number] = self
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

  def go_to_station(station)
    if station != @current_station 
      @current_station.remove_train(self)
      @current_station = station
      @current_station.receive_train(self)
    end
  end

  def validate!
    raise ArgumentError.new("Invalid number foramt") unless @number =~ NUMBER_FORMAT
    unless TRAIN_TYPES.include?(type)
      raise ArgumentError.new("Type must be only :cargo or :passenger") 
    end
  end

  @@trains = {}

end
