class RatingsCacheJob
  include SuckerPunch::Job

  def perform
    Rails.cache.fetch("ratings", expires_in: 1.hour) do
      Rating.all.to_a
    end
  end
end
