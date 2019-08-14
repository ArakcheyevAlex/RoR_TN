class Station
  attr_reader :trains, :name

  def self.find_by_name(name)
    @@stations[name]
  end

  def self.stations_list
    @@stations
  end
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
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
