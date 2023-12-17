class RatingsController < ApplicationController
  def index
    #Tässä olen käyttänyt eager loading-tekniikkaa, joka hakee 
    #tietokannasta kaikki oluet ja niiden arvostelut yhdellä kyselyllä.
    #Käytin myös sucker punchia joka hakee tarvittavat tiedot välimuistista, jos ne on saatavilla.

    @recent_ratings = Rating.includes(:beer, :user).recent
    @top_breweries = Brewery.includes(:beers, :ratings).top(3)
    @top_beers = Beer.includes(:brewery, :ratings).top(3)
    @top_raters = User.includes(:ratings).top(3)
    @ratings = Rails.cache.fetch("ratings")
    @ratings ||= Rating.includes(:beer, :user).all.to_a
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
