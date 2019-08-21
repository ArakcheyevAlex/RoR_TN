require './wagon'

class PassengerWagon < Wagon
  def initialize(capacity)
    super(:passenger, capacity)
  end

  def take_place
    load_wagon
  end
end
