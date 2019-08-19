require './wagon'
require './cargo_wagon'
require './passenger_wagon'

describe Wagon do
  it 'create wagon with correct type' do
    expect(CargoWagon.new().type).to eq(:cargo)
    expect(PassengerWagon.new().type).to eq(:passenger)
  end

  it 'check for valid' do
  	expect(CargoWagon.new.valid?).to be true
  	expect(PassengerWagon.new.valid?).to be true
  end
end
