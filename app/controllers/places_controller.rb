class PlacesController < ApplicationController
    #before_action :set_places, only: [:index, :show]
    def index
    end
    
    def search
      @places = BeermappingApi.places_in(params[:city])
      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}"
      else
        session[:city] = params[:city]
        render :index, status: 418
      end
    end

    def show
      puts "City: #{session[:city]}, ID: #{params[:id]}"
      @place = Rails.cache.read("#{session[:city]}_#{params[:id]}")
    end
  end