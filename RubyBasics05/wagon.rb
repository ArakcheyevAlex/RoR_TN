class Wagon
  attr_reader :number, :type

  @@wagon_number_sequence = 0
  
  def initialize(type)
    if type != :cargo && type != :passenger 
      raise ArgumentError.new("Type must be only :cargo or :passenger") 
    end

    @type = type
    @number = @@wagon_number_sequence.to_s
    @@wagon_number_sequence += 1
  end
end
