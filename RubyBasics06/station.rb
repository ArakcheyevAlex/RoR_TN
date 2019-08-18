require './instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  class << self
    def find_by_name(name)
      @@stations[name]
    end

    def stations_list
      @@stations
    end

    alias_method :all, :stations_list
  end

  def initialize(name)
    @name = name
    @trains = []
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

  protected
  
  @@stations = {}

end
