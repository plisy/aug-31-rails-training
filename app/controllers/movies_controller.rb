class MoviesController < ApplicationController
    def show
        movies = {
            "1" => { title: "Parasite", director: "Bong Joon-ho"},
            "2" => { title: "Titanic", director: "James Cameron"}
        }
        @movie = movies[params[:id]]
    end
end