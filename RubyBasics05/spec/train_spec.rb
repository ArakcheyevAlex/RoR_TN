require './train'
require './cargo_train'
require './passenger_train'
require './station'
require './route'
require './wagon'

describe Train do
  before(:all) do
    @station_ny = Station.new("New York")
    @station_la = Station.new("Los Angeles")
    @station_chicago = Station.new("Chicago")
    
    @passenger_train = PassengerTrain.new("001")
    @cargo_train = CargoTrain.new("002")
  
    @route_ny_la = Route.new("NY to LA", @station_ny, @station_la)
    @route_ny_la.add_station(@station_chicago)

    @cargo_wagon = Wagon.new(:cargo)
    @passenger_wagon = Wagon.new(:passenger)
    @passenger_wagon2 = Wagon.new(:passenger)
  end

  it "worng type train creatiion" do
    expect { Train.new("001", :some_type) }.to raise_error(ArgumentError, "Type must be only :cargo or :passenger")
  end

  it "train speeds up" do
    @passenger_train.stop
    @passenger_train.speed_up
    expect(@passenger_train.speed).not_to eq(0)
  end

  it "train stop" do
    @passenger_train.speed_up
    @passenger_train.stop
    expect(@passenger_train.speed).to eq(0)
  end

  it "train stopeed" do
    @passenger_train.stop
    expect(@passenger_train.stopped?).to be true
    @passenger_train.speed_up
    expect(@passenger_train.stopped?).to be false
  end

  it "set route to train" do
    @passenger_train.set_route(@route_ny_la)
    expect(@passenger_train.current_station).to eq(@station_ny)
  end

  it "next and previous stations" do
    @passenger_train.set_route(@route_ny_la)
    @passenger_train.go_to_next_station
    expect(@passenger_train.current_station).to eq(@station_chicago)
    expect(@passenger_train.next_station).to eq(@station_la)
    expect(@passenger_train.previous_station).to eq(@station_ny)
    @passenger_train.go_to_previous_station
    expect(@passenger_train.current_station).to eq(@station_ny)
  end

  it "try to direct use go_to_station" do
    expect { @passenger_train.go_to_station }.to raise_error(NoMethodError)
  end

  it 'drop wagons' do 
    @passenger_train.stop
    @passenger_train.add_wagon(@passenger_wagon)
    @passenger_train.drop_wagons
    expect(@passenger_train.wagons_count).to eq(0)
  end

  it "add same wagon twice" do
    @passenger_train.stop
    @passenger_train.drop_wagons
    @passenger_train.add_wagon(@passenger_wagon)
    @passenger_train.add_wagon(@passenger_wagon)
    expect(@passenger_train.wagons_count).to eq(1)
  end

  it "add wagons of different types" do
    @passenger_train.stop
    expect { @passenger_train.add_wagon(@cargo_wagon) }.to raise_error(ArgumentError, "Incorrect wagon type")
    
    @cargo_train.stop
    expect { @cargo_train.add_wagon(@passenger_wagon) }.to raise_error(ArgumentError, "Incorrect wagon type")
    
    @passenger_train.drop_wagons
    @passenger_train.add_wagon(@passenger_wagon)
    expect(@passenger_train.wagons_count).to eq(1)

    @cargo_train.drop_wagons
    @cargo_train.add_wagon(@cargo_wagon)
    expect(@cargo_train.wagons_count).to eq(1)
  end

  it 'remove wagons' do
    @passenger_train.stop
    @passenger_train.drop_wagons
    @passenger_train.add_wagon(@passenger_wagon)
    @passenger_train.add_wagon(@passenger_wagon2)
    expect(@passenger_train.wagons_count).to eq(2)
    @passenger_train.remove_wagon(@passenger_wagon)
    expect(@passenger_train.wagons_count).to eq(1)
    @passenger_train.remove_wagon(@passenger_wagon)
    expect(@passenger_train.wagons_count).to eq(1)
  end
end
