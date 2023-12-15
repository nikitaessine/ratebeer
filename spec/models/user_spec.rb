require 'rails_helper'

RSpec.describe User, type: :model do

  after(:each) do
    User.destroy_all
  end

  it "has the username set correctly" do
    user = User.new username: "Vilma"

    expect(user.username).to eq("Vilma")
  end

  it "is not saved without a password" do
    user = User.create username: "Vilma"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a too short password" do
    user = User.create username: "Vilma", password: "abc", password_confirmation: "abc"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password consisting of lowercase letters only" do
    user = User.create username: "Vilma", password: "secret", password_confirmation: "secret"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    after(:each) do
      User.destroy_all
    end
    let(:user){ FactoryBot.create(:user) }
    style = FactoryBot.create(:style, name: "Lager")

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer, style: style)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end
 # describe User

def create_beer_with_rating(object, score)
  style = FactoryBot.create(:style, name: "Lager")
  beer = FactoryBot.create(:beer, style: style)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      style = FactoryBot.create(:style, name: "Lager")
      beer = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, score: 10, user: user, beer: beer)
      FactoryBot.create(:rating, score: 20, user: user, beer: beer)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end