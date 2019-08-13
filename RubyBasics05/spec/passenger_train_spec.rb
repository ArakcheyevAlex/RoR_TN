require './passenger_train'

describe PassengerTrain do
  before(:all) do
    @passenger_train = PassengerTrain.new("003")
  end

  it "create passenger train with correct type" do
    expect(@passenger_train.type).to eq(:passenger)
  end
end
