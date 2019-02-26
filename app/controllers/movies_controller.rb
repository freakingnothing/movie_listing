class MoviesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_list
  
    def create
      @movie = Movie.create(movie_params)
      if @movie.save
        @list.movies << @movie
        redirect_to_list_path(@list)
      else
        flash[:danger] = 'Error'
      end
    end
  
    private
  
    def movie_params
      params.require(:movie).permit(:url,
                                    :rus_title,
                                    :original_title,
                                    :release_year,
                                    :rating,
                                    :genre,
                                    :url)
    end
  
    def find_list
      @list = List.find(params[:id])
    end
  end
  