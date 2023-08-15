module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings_count = ratings.count
    return 0 if ratings_count.zero?

    total_score = ratings.sum(:score)
    (total_score.to_f / ratings_count).round(2)
  end
end
