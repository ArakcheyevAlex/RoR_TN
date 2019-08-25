require './passenger_train'

describe PassengerTrain do
  before(:all) do
    @passenger_train = PassengerTrain.new('003-dd')
  end

  it 'create passenger train with correct type' do
    expect(@passenger_train.type).to eq(:passenger)
  end

  it 'check for valid' do
    expect(@passenger_train.valid?).to be true
  end
end
