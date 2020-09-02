class MoviesController < ApplicationController
    def show
        movie = Movie.find(params[:id])
        render locals: { movie: movie }
    end

    def index
        movies = Movie.take 10
        render locals: { movies: movies }
    end

    def new
        movie = Movie.new
        render locals: { movie: movie }
    end

    def create       
        movie = Movie.create(movie_params)
        redirect_to action: :show, id: movie.id
    end

    def edit
        movie = Movie.find(params[:id])
        render locals: { movie: movie }
    end

    def update
        movie = Movie.find(params[:id])
        movie.update(movie_params)
        redirect_to action: :show, id: movie.id
    end

    def movie_params
        params.require(:movie).permit(:title, :director, :year)
    end
end