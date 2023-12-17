require 'webdrivers'
Webdrivers::Chromedriver.required_version = '120.0.6099.0'
require 'rails_helper'

describe "Beerlist page" do
    before :all do
        Capybara.register_driver :selenium do |app|
          Capybara::Selenium::Driver.new(app, :browser => :chrome)
        end
        WebMock.allow_net_connect!
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path

    expect(page).to have_content "Nikolai"
  end

  it "shows beers ordered by name", js:true do
    visit beerlist_path
  
    rows = find('#beertable').all('.tablerow')
    beer_names = rows.map { |r| r.find('td').text }
  
    expect(beer_names).to eq(beer_names.sort)
  end

  it "when clicked on 'style', orders beers by style in alphabetical order", js:true do
    visit beerlist_path
  
    find('table').find('th', text: 'Style').click
  
    rows = find('#beertable').all('.tablerow')
    beer_styles = rows.map { |r| r.all('td')[1].text } # assuming style is the second column
  
    expect(beer_styles).to eq(beer_styles.sort)
  end
  
  it "when clicked on 'brewery', orders beers by brewery in alphabetical order", js:true do
    visit beerlist_path
  
    find('table').find('th', text: 'Brewery').click
  
    rows = find('#beertable').all('.tablerow')
    beer_breweries = rows.map { |r| r.all('td')[2].text } # assuming brewery is the third column
  
    expect(beer_breweries).to eq(beer_breweries.sort)
  end
end