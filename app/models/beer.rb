class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    if ratings.empty?
      return nil
    else
      total_scores = ratings.sum(:score)
      total_ratings = ratings.count
      average = total_scores.to_f / total_ratings
      return average
    end
  end
end
  