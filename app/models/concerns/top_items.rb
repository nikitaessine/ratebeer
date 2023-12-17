module TopItems
  extend ActiveSupport::Concern
  
  class_methods do
    def top(how_many)
      sorted_items = all.sort_by(&:average_rating).reverse
      sorted_items.take(how_many)
    end
  end
end