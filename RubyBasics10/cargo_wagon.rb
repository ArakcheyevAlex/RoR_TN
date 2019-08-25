require './wagon'

class CargoWagon < Wagon
  def initialize(capacity)
    super(:cargo, capacity)
  end
end
