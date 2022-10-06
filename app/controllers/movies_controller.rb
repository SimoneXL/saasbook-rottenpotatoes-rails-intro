class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if !params.key?(:ratings)
      params[:ratings] = Hash[Movie.all_ratings.collect { |item| [item, "1"] } ]
    end

    @redirect_f = false

    if session.key?(:sort) && params[:commit] != "Refresh" && !params.key?(:sort)
      @redirect_f = true
      params[:sort] = session[:sort]
    end

    if session.key?(:ratings) && !params.key?(:ratings)
      @redirect_f = true
      params[:ratings] = session[:ratings]
      
    end

    if @redirect_f
      redirect_to movies_path(:ratings => params[:ratings], :sort => params[:sort])
    end

    

    @all_ratings = Movie.all_ratings
    @ratings_to_show = Movie.check_ratings(params)

    if (session.key?(:sort) && params[:commit] == "Refresh")
      params[:sort] = session[:sort]
    end
    
    
    if !params.key?(:sort) 
      @movies_to_show = Movie.with_ratings(@ratings_to_show)
      @title_bg = ''
      @date_bg = ''
    else
      if params[:sort] == 'title'
        @movies_to_show = Movie.with_ratings(@ratings_to_show, :title)
        @title_bg = 'hilite'
        @date_bg = ''
      else
        @movies_to_show = Movie.with_ratings(@ratings_to_show, :release_date)
        @title_bg = ''
        @date_bg = 'hilite'
      end
      
    end
    
    session[:ratings] = params[:ratings]

    if params.key?(:sort) && params[:commit] != "Refresh"
      session[:sort] = params[:sort]
    end

    


  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
