class Station
  attr_reader :trains, :name

  def self.find_by_name(name)
    @@stations.each do |station| 
      return station if station.name == name
    end
    nil
  end

  def self.stations_list
    @@stations
  end
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
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
  
  @@stations = []

end
