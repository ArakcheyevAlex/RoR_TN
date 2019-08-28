require './train'
require './instance_counter'

class PassengerTrain < Train
  include InstanceCounter

  validate :number, :format, NUMBER_FORMAT
  validate :type, :allowed_values, TRAIN_TYPES

  def initialize(number)
    super(number, :passenger)
    register_instance
  end
end
