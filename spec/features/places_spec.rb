require 'rails_helper'

describe "Places" do
  context "when API returns results" do
    it "displays all returned places on the page" do
      allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1), Place.new(name: "ToinenPaikka", id: 2)]
      )

      visit places_path
      fill_in('city', with: 'kumpula')
      click_button "Search"

      expect(page).to have_content "Oljenkorsi"
      expect(page).to have_content "ToinenPaikka"
    end
  end

  context "when API does not find any locations" do
    it "displays a message 'No locations in the city on the page" do
      city = 'kumpula'
      allow(BeermappingApi).to receive(:places_in).with(city).and_return([])

      visit places_path
      fill_in('city', with: city)
      click_button "Search"

      expect(page).to have_content "No locations in #{city}"
    end
  end
end

