require './train'
require './instance_counter'

class CargoTrain < Train
  include InstanceCounter

  validate :number, :format, NUMBER_FORMAT
  validate :type, :allowed_values, TRAIN_TYPES

  def initialize(number)
    super(number, :cargo)
    register_instance
  end
end
