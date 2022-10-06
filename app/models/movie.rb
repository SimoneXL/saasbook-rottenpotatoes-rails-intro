class Movie < ActiveRecord::Base

  def self.all_ratings
      ['G','PG','PG-13','R']
  end

  def self.check_ratings(param)

      if param[:ratings].nil? || param[:ratings]==[]
          return []
      end
      
      return param[:ratings].keys
  end

  def self.with_ratings(ratings_list, order = nil)

      if order.nil?
          if ratings_list.nil? || !ratings_list.length
              return Movie.all
          else
              return Movie.where(rating: ratings_list)
          end
      else
          if ratings_list.nil? || !ratings_list.length
              if order == :title
                  return Movie.all.order(:title)
              else
                  return Movie.all.order(:release_date)
              end
          else
              if order == :title
                  return Movie.where(rating: ratings_list).order(:title)
              else
                  return Movie.where(rating: ratings_list).order(:release_date)
              end
          end
      end

  end
end