require './manufacturer'
require './validator'

class Wagon
  include Manufacturer
  include Validator

  WAGON_TYPES = [:cargo, :passenger].freeze

  attr_reader :number, :type, :capacity, :occupied, :wagons

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

  def validate!
    unless WAGON_TYPES.include?(type)
      raise ArgumentError, 'Type must be only :cargo or :passenger'
    end

    raise ArgumentError, "Number can't be nil" if @number.nil?

    # rubocop:disable Style/GuardClause
    if @capacity.nil? || @capacity.zero?
      raise ArgumentError, "Capacity can't be 0 or nil"
    end
    # rubocop:enable Style/GuardClause
  end

  @@wagons = {}
end
