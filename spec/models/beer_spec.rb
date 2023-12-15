require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is not saved without a name" do
    beer = Beer.create name: ""

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name: "Test Beer"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with a proper name, style and brewery" do
    let(:test_brewery) { Brewery.new name: "Koff", year: 2000 }
    let(:test_style) { Style.create name: "Lager" }
    let(:test_beer) { Beer.create name: "Blanc", style: test_style, brewery: test_brewery }

    it "is saved" do
      expect(test_beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
