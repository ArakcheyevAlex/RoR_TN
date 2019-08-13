require './station'
require './train'
require './cargo_train'
require './passenger_train'

describe Station do

  before(:all) do
    @station_ny = Station.new("New York")
    @passenger_train = PassengerTrain.new("001")
    @cargo_train = CargoTrain.new("002")
  end
  
  it 'create station' do
    expect(@station_ny.name).to eq "New York"
  end

  it 'check that trains list is empty' do
    expect(@station_ny.trains).to be_empty
  end

  it 'check that train added to list' do
    @station_ny.receive_train(@passenger_train)
    expect(@station_ny.trains.count).to eq 1
  end

  it "check that train didn't add twice" do
    @station_ny.receive_train(@passenger_train)
    expect(@station_ny.trains.count).to eq 1
  end

  it 'check that train removed from list' do
    @station_ny.remove_train(@passenger_train)
    expect(@station_ny.trains).to be_empty
  end

  it 'list of trains by types' do
    @station_ny.receive_train(@passenger_train)
    @station_ny.receive_train(@cargo_train)

    expect(@station_ny.trains_by_type(:cargo)[0]).to eq(@cargo_train)
    expect(@station_ny.trains_by_type(:passenger)[0]).to eq(@passenger_train)
    expect(@station_ny.trains_by_type(:some_type)[0]).to be_nil
  end

end
