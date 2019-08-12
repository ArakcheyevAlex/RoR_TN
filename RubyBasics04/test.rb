puts "создание станций"
st_ekb = Station.new("Екатеринбург")
st_omsk = Station.new("Омск")
st_moskva = Station.new("Москва")
st_kazan = Station.new("Казань")

puts "списки поездов на станциях"
st_ekb.trains
st_omsk.trains
st_moskva.trains
st_kazan.trains

puts "создание маршрута, добавление станций"
route_omsk_msk = Route.new(st_omsk, st_moskva)
route_omsk_msk.add_station(st_ekb)
route_omsk_msk.show_stations_list
route_omsk_msk.add_station(st_kazan)
route_omsk_msk.show_stations_list
route_omsk_msk.stations_list
route_omsk_msk.stations_list.first
route_omsk_msk.stations_list.last

puts "удаление станций"
route_omsk_msk.delete_station(st_kazan)
route_omsk_msk.show_stations_list
route_omsk_msk.add_station(st_kazan)
route_omsk_msk.show_stations_list

puts "создание поезда"
train_omsk_msk_pass = Train.new("135", :passengers)
train_omsk_msk_cargo = Train.new("333", :cargo)
train_omsk_msk_wrong = Train.new("456", :some_else)

puts "скорость поезда"
train_omsk_msk_pass.stopped?
train_omsk_msk_pass.speed_up(20)
train_omsk_msk_pass.speed
train_omsk_msk_pass.speed_up
train_omsk_msk_pass.speed
train_omsk_msk_pass.stopped?
train_omsk_msk_pass.stop
train_omsk_msk_pass.stopped?

puts "вагоны"
train_omsk_msk_pass.wagons_count
train_omsk_msk_pass.add_wagon
train_omsk_msk_pass.wagons_count
train_omsk_msk_pass.remove_wagon
train_omsk_msk_pass.wagons_count
train_omsk_msk_pass.speed_up
train_omsk_msk_pass.remove_wagon
train_omsk_msk_pass.wagons_count

puts "назначение маршрута"
train_omsk_msk_pass.current_station.name
train_omsk_msk_cargo.current_station.name
train_omsk_msk_pass.set_route(route_omsk_msk)
train_omsk_msk_cargo.set_route(route_omsk_msk)
train_omsk_msk_pass.current_station.name
train_omsk_msk_cargo.current_station.name

puts "движение поезда"
train_omsk_msk_pass.set_route(route_omsk_msk)
train_omsk_msk_cargo.set_route(route_omsk_msk)

train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_next_station
train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_next_station
train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_next_station
train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_next_station
train_omsk_msk_pass.current_station.name

train_omsk_msk_pass.go_to_previous_station
train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_previous_station
train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_previous_station
train_omsk_msk_pass.current_station.name
train_omsk_msk_pass.go_to_previous_station
train_omsk_msk_pass.current_station.name

puts "проверка что поезда есть в списке поездов на станциях"
train_omsk_msk_cargo.go_to_next_station
train_omsk_msk_cargo.current_station.name

st_ekb.trains
st_omsk.trains
st_moskva.trains
st_kazan.trains
