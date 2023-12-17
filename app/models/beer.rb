class Beer < ApplicationRecord
  include RatingAverage
  include TopItems

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  after_save :update_brewery
  after_destroy :update_brewery

  def self.top(amount)
    sorted_beers = Beer.all.sort_by(&:average_rating).reverse

    sorted_beers.take(amount)
  end

  def to_s
    "#{name} #{brewery.name}"
  end

  def average_rating
    return 0 if ratings.empty?

    ratings.average(:score)
  end

  private

  def update_brewery
    brewery.touch
  end

end
