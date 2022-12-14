class Movie < ActiveRecord::Base

    def self.all_ratings
        ['G','PG','PG-13','R']
    end

    def self.check_ratings(par)

        if par[:ratings].nil? || par[:ratings] == []
            return []
        end
        
        return par[:ratings].keys
    end

    def self.with_ratings(ratings_list, order = nil)

        if !order.nil?
            if ratings_list.nil? || ratings_list == []
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
        else
            if ratings_list.nil? || ratings_list == []
                return Movie.all
            else
                return Movie.where(rating: ratings_list)
            end
        end

    end
end
