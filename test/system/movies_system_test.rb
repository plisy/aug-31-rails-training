require "application_system_test_case"

class MoviesSystemTest < ApplicationSystemTestCase
  test "visiting the show" do
    attributes = { title: "Parasite", director: "Bong Joon-ho" }
    movie = Movie.create(attributes)

    visit "/movies/#{movie.id}"
    
    assert_text movie.title
    assert_text movie.director
  end

  test "listing the shows" do
    movie_1 = Movie.create({ title: "Parasite", director: "Bong Joon-ho" })
    movie_2 = Movie.create({ title: "Avatar", director: "James Cameron" })

    visit "/movies"
    
    assert_text movie_1.title
    assert_text movie_1.director
    assert_text movie_2.title
    assert_text movie_2.director
  end

  test "creating a new movie" do
    visit "/movies"

    assert_button "Add New Movie"
    click_button "Add New Movie"

    # Redirect to new movie form
    assert_current_path "/movies/new"
    assert_selector ".new_movie"
    fill_in :movie_title, with: "Demo Movie"
    fill_in :movie_director, with: "The Director"
    fill_in :movie_year, with: "2020"
    click_button "Add Movie"

    # Redirect to show page for the new movie
    assert_text "Demo Movie"
    assert_text "The Director"
    assert_text "2020"
  end

  test "edit a new movie" do
    movie = Movie.create({ title: "Avatar", director: "James Cameron", year: "2008" })
    visit "/movies/#{movie.id}"

    assert_button "Edit #{movie.title}"
    click_button "Edit #{movie.title}"

    # Redirect to new movie form
    assert_current_path "/movies/#{movie.id}/edit"
    assert_selector ".edit_movie"
    fill_in :movie_year, with: "2009"
    click_button "Edit #{movie.title}"

    # Redirect to show page for the new movie
    assert_text "Avatar"
    assert_text "James Cameron"
    assert_text "2009"
  end
end
