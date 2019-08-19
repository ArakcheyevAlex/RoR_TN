require './cargo_train'

describe CargoTrain do  
  before(:all) do
    @cargo_train = CargoTrain.new("004")
  end

  it "create cargo train with correct type" do
    expect(@cargo_train.type).to eq(:cargo)
  end
end
