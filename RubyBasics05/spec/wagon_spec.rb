require './wagon'

describe Wagon do
  it 'create wagon with correct type' do
    expect { Wagon.new(:some_type) }.to raise_error(ArgumentError, "Type must be only :cargo or :passenger")
    expect(Wagon.new(:cargo).number).not_to be_empty
    expect(Wagon.new(:passenger).number).not_to be_empty
  end
end
