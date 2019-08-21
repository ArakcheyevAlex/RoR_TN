require './instance_counter'
require './validator'

class Station
  include InstanceCounter
  include Validator

  attr_reader :trains, :name

  class << self
    def find_by_name(name)
      @@stations[name]
    end

    def stations_list
      @@stations
    end

    alias all stations_list
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations[name] = self
    register_instance
  end

  def receive_train(train)
    @trains << train unless @trains.include?(train)
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def trains_each
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise ArgumentError, "Name can't be nil" if @name.nil?
  end

  @@stations = {}
end
