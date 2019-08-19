require './manufacturer'

class Wagon
  include Manufacturer

  attr_reader :number, :type

  protected

  @@wagon_number_sequence = 0
  
  def initialize(type)
    @type = type
    @number = @@wagon_number_sequence.to_s
    @@wagon_number_sequence += 1
  end
end
