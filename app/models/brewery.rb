class Brewery < ApplicationRecord
  include RatingAverage
  include TopItems

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validate :brewery_date_within_range

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def brewery_date_within_range
    return unless year.present? && (year < 1040 || year > Time.now.year)

    errors.add(:year, "must be between 1040 and #{Time.now.year}")
  end

  def self.top(amount)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by(&:average_rating).reverse

    sorted_by_rating_in_desc_order.take(amount)
  end
  
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
