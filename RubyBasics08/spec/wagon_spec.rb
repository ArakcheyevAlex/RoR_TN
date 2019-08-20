require './wagon'
require './cargo_wagon'
require './passenger_wagon'

describe Wagon do
  before(:all) do
    @cargo_wagon = CargoWagon.new(100)
    @passenger_wagon = PassengerWagon.new(50)
  end

  it 'create wagon with correct type' do
    expect(@cargo_wagon.type).to eq(:cargo)
    expect(@passenger_wagon.type).to eq(:passenger)
  end

  it 'check for valid' do
    expect(@cargo_wagon.valid?).to be true
    expect(@passenger_wagon.valid?).to be true
  end

  it 'wagon capacity' do
    expect(@cargo_wagon.capacity).to eq(100)
    expect(@passenger_wagon.capacity).to eq(50)
  end

  it 'available places in passenger wagon' do
    expect(@passenger_wagon.available).to eq(50)
    @passenger_wagon.take_place
    expect(@passenger_wagon.occupied).to eq(1)
    expect(@passenger_wagon.available).to eq(49)
  end

  it 'available volume in cargo wagon' do
    expect(@cargo_wagon.available).to eq(100)
    @cargo_wagon.load_wagon(40)
    expect(@cargo_wagon.occupied).to eq(40)
    expect(@cargo_wagon.available).to eq(60)
  end

  it 'overload of passenger wagon' do
    49.times { @passenger_wagon.take_place }
    expect(@passenger_wagon.available).to eq(0)
    expect { @passenger_wagon.take_place }.to raise_error(RuntimeError, "No free space")
  end

  it 'overload of cargo wagon' do
    @cargo_wagon.load_wagon(50)
    expect(@cargo_wagon.available).to eq(10)
    expect { @cargo_wagon.load_wagon(20)}.to raise_error(RuntimeError, "No free space")
  end

end
