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

  def self.with_ratings(ratings_list)
    if ratings_list.nil? || ratings_list == []
      return Movie.a;;
    else
      return Movie.where(rating: ratings_list)
    end
end
