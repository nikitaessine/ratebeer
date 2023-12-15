require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style) { FactoryBot.create :style, name: "Lager" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery, style: style }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery, style: style }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Kalle", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "displays existing ratings and their count" do

    style = FactoryBot.create(:style, name: "Lager")
    beer = FactoryBot.create(:beer, name: "Beer 1", style: style)
    FactoryBot.create(:rating, user: user, score: 15, beer: beer)
  
    visit ratings_path
    Rating.all.each do |r|
        expect(page).to have_content r.score
        expect(page).to have_content r.user.username
        expect(page).to have_content r.beer.name
    end
  end
end
