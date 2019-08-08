class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_list, only: %i[create change_status destroy]

  def completed_movies
    @pagy, @completed_movies = pagy(Movie.completed_all(current_user))
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.url = @movie.sanitize_url

    if @movie.check_source == 'None'
      flash[:danger] = 'Sorry! Not supported!'
    elsif @movie.is_new?
      @movie.add_mobile_url
      @movie.add_source
      @movie.add_scraper_result
      @list.movies << @movie if @movie.save
    else
      @list.movies << @movie.find_existing_movie if @movie.not_in_list?(@list)
    end

    redirect_to list_path(@list)
  end

  def change_status
    @movie = Movie.find(params[:movie_id])
    @movie.toggle_status(@list)

    redirect_to list_path(@list)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.lists.delete(@list.id)

    redirect_to list_path(@list)
  end

  private

  def movie_params
    params.require(:movie).permit(:url)
  end

  def find_list
    @list = List.find(params[:list_id])
  end
end
