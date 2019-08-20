require './manufacturer'
require './validator'

class Wagon
  include Manufacturer
  include Validator

  WAGON_TYPES = [:cargo, :passenger]

  attr_reader :number, :type

  protected

  @@wagon_number_sequence = 0
  
  def initialize(type)
    @type = type
    @number = @@wagon_number_sequence.to_s
    validate!
    @@wagon_number_sequence += 1
  end

  def validate!
  	unless WAGON_TYPES.include?(type)
      raise ArgumentError.new("Type must be only :cargo or :passenger") 
    end
    raise ArgumentError.new("Number can't be nil") if @number.nil?
  end
end
