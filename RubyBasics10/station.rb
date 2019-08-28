require './instance_counter'
require './validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  validate :name, :presence

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

  @@stations = {}
end
