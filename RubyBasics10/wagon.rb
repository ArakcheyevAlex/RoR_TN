require './manufacturer'
require './validation'

class Wagon
  include Manufacturer
  include Validation

  WAGON_TYPES = [:cargo, :passenger].freeze

  attr_reader :number, :type, :capacity, :occupied, :wagons

  validate :number, :presence
  validate :type, :allowed_values, WAGON_TYPES
  validate :capacity, :presence

  class << self
    def find_by_number(number)
      @@wagons[number]
    end

    alias find find_by_number
  end

  def available
    @capacity - @occupied
  end

  def load_wagon(value = 1)
    raise 'No free space' if @occupied + value > @capacity

    @occupied += value
  end

  def description
    "##{number}, #{type}, capacity: #{capacity}" \
    "available: #{available}, occupied: #{occupied}"
  end

  protected

  @@wagon_number_sequence = 0

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    @occupied = 0
    @number = @@wagon_number_sequence.to_s
    validate!
    @@wagon_number_sequence += 1
    @@wagons[@number] = self
  end

  @@wagons = {}
end
