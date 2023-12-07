require 'rails_helper'

describe "Places" do

  let(:mock_weather) do
    {
      "observation_time" => "10:01 PM",
      "temperature" => 10,
      "weather_code" => 296,
      "weather_icons" => ["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0033_cloudy_with_light_rain_night.png"],
      "weather_descriptions" => ["Light Rain, Mist"],
      "wind_speed" => 13,
      "wind_degree" => 190,
      "wind_dir" => "S",
      "pressure" => 1001,
      "precip" => 0,
      "humidity" => 89,
      "cloudcover" => 100,
      "feelslike" => 8,
      "uv_index" => 1,
      "visibility" => 6,
      "is_day" => "no"
    }
  end
  
  before do
    ["helsinki", "madrid", "new york"].each do |city|
      allow(WeatherstackApi).to receive(:weather_in).with(city).and_return(mock_weather)
    end
  end

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

