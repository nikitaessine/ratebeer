class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy

    def print_report
      puts name
      puts "established at year #{year}"
      puts "number of beers #{beers.count}"
    end

    def restart
      year = 2022
      puts "changed year to #{year}"
    end

  end
