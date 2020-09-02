
require 'test_helper'
 
class MovieTest < ActiveSupport::TestCase
  test "movie is valid with a title" do
     movie = Movie.create(title: "Parasite", director: "Bong Joon-ho")

     assert_equal "Parasite", movie.title
     assert_equal "Bong Joon-ho", movie.director
     assert movie.valid?
  end

  test "movie is invalid without a title" do
      movie = Movie.create(title: "", director: "Bong Joon-ho")

      refute movie.valid?
  end

  test "count by likes does not count likes less than or equal to N" do
    Movie.create(title: "test", facebook_likes: 1)

    result = Movie.count_more_than_n_likes 1
    assert_equal 0, result
  end 
  
  test "count by likes counts likes greater than N" do
    Movie.create(title: "test", facebook_likes: 1)

    result = Movie.count_more_than_n_likes 0
    assert_equal 1, result
  end 

  test "titles finds all titles" do
    Movie.create(title: "One")
    Movie.create(title: "Two")
    Movie.create(title: "Duplicate")
    Movie.create(title: "Duplicate")

    result = Movie.titles
    assert_equal 4, result.count
    assert_includes result, "One"
    assert_includes result, "Two"
    assert_includes result, "Duplicate"
  end

  test "movies by director after 2010 finds correct movies" do
    movie_1 = Movie.create(title: "Correct 1", director: "Tom Hanks", year: 2011)
    movie_2 = Movie.create(title: "Correct 2", director: "Tom Hanks", year: 2020)

    result = Movie.movies_by_director_after_2010 "Tom Hanks"
    assert_equal [movie_1, movie_2], result
  end

  test "movies by director after 2010 does not find older movies" do
    Movie.create(title: "Incorrect 1", director: "Tom Hanks", year: 2010)
    Movie.create(title: "Incorrect 2", director: "Tom Hanks", year: 1999)

    result = Movie.movies_by_director_after_2010 "Tom Hanks"
    assert_equal 0, result.count
  end

  test "movies by director after 2010 does not find movies from the wrong director" do
    Movie.create(title: "Incorrect 1", director: "Tim Hanks", year: 2020)
    Movie.create(title: "Incorrect 2", director: "Someone Else", year: 2020)

    result = Movie.movies_by_director_after_2010 "Tom Hanks"
    assert_equal 0, result.count
  end
end