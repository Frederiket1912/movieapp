require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
   test "visiting the index" do
     visit movies_url
  
     assert_selector "h1", text: "Movies"
   end

   test "creating a movie" do
    visit movies_path 
    click_on "New Movie" 
    fill_in "title", with: "Titanic"
    click_on "Search"
   
    assert_text "Titanic"
  end

  test "add comment to movie" do
    visit movies_path
    click_on "New Movie"
    fill_in "title", with: "Titanic"
    click_on "Search"
    click_on "Titanic"
    click_on "Comment on Movie"
    fill_in "movie[comment]", with: "test comment"
    click_on "Update Comment"

    assert_text "test comment"
  end

  test "fixture exist" do
    visit movies_path

    assert_text "MyString"
  end

  test "delete fixture movie" do
    visit movie_path(980190962)
    accept_confirm do
      click_on "Remove Movie"
    end

    assert_no_text "MyString"
  end

  test "delete movie" do
    visit movies_path
    click_on "New Movie"
    fill_in "title", with: "Titanic"
    click_on "Search"
    click_on "Titanic"
    accept_confirm do
      click_on "Remove Movie"
    end

    assert_no_text "Titanic"
  end
end
