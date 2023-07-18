class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def print_report
      puts name
      puts "established at year #{year}"
      puts "number of beers #{beers.count}"
    end

    def restart
      year = 2022
      puts "changed year to #{year}"
    end
    

    def average_rating
      ratings_count = ratings.count
      return 0 if ratings_count.zero?
  
      total_score = ratings.sum(:score)
      (total_score.to_f / ratings_count).round(2)
    end

  end
