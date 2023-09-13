# spec/features/beers_spec.rb

require 'rails_helper'

RSpec.describe "Beers", type: :feature do
  before(:each) do
    FactoryBot.create(:brewery, name: "Lahden panimo")
  end

  it "can be added if the beer name is valid" do
    visit new_beer_path

    fill_in 'beer_name', with: 'Kruchovice'
    select 'Lahden panimo', from: 'beer_brewery_id'

    click_button 'Create Beer'

    expect(page).to have_content 'Beer was successfully created.'
  end

  it "displays an error if the beer name is invalid and doesn't save to the database" do
    visit new_beer_path

    select 'Lahden panimo', from: 'beer_brewery_id'

    click_button 'Create Beer'

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content 'New beer'

    expect(Beer.count).to eq(0)
  end
end
