require './station'
require './train'
require './cargo_train'
require './passenger_train'

describe Station do
  before(:all) do
    @station_ny = Station.new('New York')
    @passenger_train = PassengerTrain.new('001-df')
    @cargo_train = CargoTrain.new('002-dd')
  end

  it 'create station' do
    expect(@station_ny.name).to eq 'New York'
  end

  it 'check for valid' do
    expect(@station_ny.valid?).to be true
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

  it 'stations list' do
    expect(Station.stations_list['New York']).to eq(@station_ny)
    expect(Station.all['New York']).to eq(@station_ny)
  end

  it 'find station by name' do
    expect(Station.find_by_name('New York')).to eq(@station_ny)
  end
end
