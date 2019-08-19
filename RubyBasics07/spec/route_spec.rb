#require './train'
require './station'
require './route'

describe Route do
  before(:all) do
    @station_ny = Station.new("New York")
    @station_la = Station.new("Los Angeles")
    @station_chicago = Station.new("Chicago")
    
    #@passengers_train = Train.new("001", :passengers )
    #@cargo_train = Train.new("002", :cargo )
  
    @route_ny_la = Route.new("NY to LA", @station_ny, @station_la)
  end

  it 'creates new route' do
    expect(@route_ny_la.stations_list.first).to eq(@station_ny)
    expect(@route_ny_la.stations_list.last).to eq(@station_la)
  end

  it 'add new station to route' do
    @route_ny_la.add_station(@station_chicago)
    expect(@route_ny_la.stations_list[-2]).to eq(@station_chicago)
  end

  it 'next and previous stations' do
    @route_ny_la.add_station(@station_chicago)
    expect(@route_ny_la.next_station(@station_chicago)).to eq(@station_la)
    expect(@route_ny_la.previous_station(@station_chicago)).to eq(@station_ny)
  end
end
