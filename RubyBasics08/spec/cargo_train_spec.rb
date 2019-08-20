require './cargo_train'

describe CargoTrain do  
  before(:all) do
    @cargo_train = CargoTrain.new("004-aa")
  end

  it "create cargo train with correct type" do
    expect(@cargo_train.type).to eq(:cargo)
  end

  it 'check for valid' do
  	expect(@cargo_train.valid?).to be true
  end
end
