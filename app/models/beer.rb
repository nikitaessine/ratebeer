class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    if ratings.empty?
      return nil
    else
      total_scores = ratings.map(&:score).sum
      total_ratings = ratings.size
      average = total_scores.to_f / total_ratings
      return average
    end
  end

  def to_s
    "#{name} (Brewery: #{brewery.name})"
  end

end
  