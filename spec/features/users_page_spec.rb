require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content @user.username
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end

describe "User's Ratings" do
    before :each do
        @user = FactoryBot.create(:user, username: "Kalle", password: "Foobar1")
        @user2 = FactoryBot.create(:user, username: "Anna", password: "Password1", password_confirmation: "Password1")

        @beer1 = FactoryBot.create(:beer, name: "Beer 1")
        @beer2 = FactoryBot.create(:beer, name: "Beer 2")

        FactoryBot.create(:rating, score: 4, user: @user, beer: @beer1)
        FactoryBot.create(:rating, score: 3, user: @user, beer: @beer2)

        FactoryBot.create(:rating, score: 5, user: @user2, beer: @beer1)

        sign_in(username: "Kalle", password: "Foobar1")
    end

    it "displays user's own ratings but not other users'" do
        visit user_path(@user)

        expect(page).to have_content "Beer 1 4"
        expect(page).to have_content "Beer 2 3"

        expect(page).not_to have_content "Beer 1 5"
    end

    it "can be deleted by user" do
        visit user_path(@user)
    
        expect {
          find('a[data-turbo-method="delete"][href="/ratings/1"]').click
        }.to change { @user.ratings.count }.from(2).to(1)
    end
    
end

