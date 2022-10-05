class Movie < ActiveRecord::Base

  def self.all_ratings
    ['G', 'PG', 'PG-13','R']
  end
  attr_accessor :all_ratings

  def self.check_ratings(p)
    if p[:ratings].nil? || p[:ratings] == []
      return []
    end

    return p[:ratings].keys
  end

  def self.with_ratings(ratings_list, order = nil)
    if order.nil?
      if ratings_list.nil? || ratings_list == []
        return Movie.all;;
      else
        return Movie.where(rating: ratings_list)
      end
    else
      if ratings_list.nil? || ratings_list == []
        if order == :title
          return Movie.all.order(:title)
        else
          return Movie.all.order(:release_date)
end
