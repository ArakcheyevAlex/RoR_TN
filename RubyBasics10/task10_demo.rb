require './station'
require './train'
require './cargo_train'
require './passenger_train'
require './route'
require './cargo_wagon'
require './passenger_wagon'
require './accessors'

def show_obj(object)
  puts object.inspect
  puts "Valid?: #{object.valid?}"
end

def test_object
  yield
rescue ArgumentError => e
  puts e.message
  e.backtrace.each { |str| puts str }
end

puts 'Validations demo::'

puts 'Valid objects:'
show_obj CargoTrain.new('333-vv')

station_ny = Station.new('NY')
station_la = Station.new('LA')
show_obj station_la
show_obj station_ny

show_obj Route.new('NY to LA', station_ny, station_la)
show_obj CargoWagon.new(100)

puts 'Invalid objects:'
test_object { CargoTrain.new('StrangeName') }
test_object { station_ny = Station.new(nil) }
test_object { Route.new(nil, station_ny, nil) }
test_object { Wagon.new(:some_type, nil) }
test_object { Wagon.new(:cargo, nil) }

puts 'Attribute history'
train = Train.new('333-vv', :cargo)
train.color = :red
puts train.color
train.color = :green
puts train.color
train.color = :gray
puts train.color
train.color = :black
puts train.color
puts 'history:'
puts train.color_history.inspect

puts 'Strong accessors demo::'

class Foo
  extend Accessors
  strong_attr_accessor :name, String
end

foo = Foo.new
foo.name = 'Woodoo'
puts foo.name

begin
  foo.name = 123_456.0
rescue ArgumentError => e
  puts e.message
end
