require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password", role: 1)
    # i = 1
    # 20.times do 
    #   Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
    #   i+=1
    # end 

    visit root_path
    click_on 'I already have an account'
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_on 'Log In'
  end 

  it 'shows all movies' do 
    movie = Movie.create(title: "Movie 1 Title", rating: 5, description: "This is a description about Movie 1", id: 1)
    visit dashboard_path(@user1)
    click_button "Find Top Rated Movies"

    expect(current_path).to eq(movies_path(@user1))

    expect(page).to have_content("Top Rated Movies")
    # binding.pry
    # movie_1 = Movie.last

    click_link(movie.title)

    expect(current_path).to eq("/movies/#{movie.id}")

    expect(page).to have_content(movie.title)
    expect(page).to have_content(movie.description)
    expect(page).to have_content(movie.rating)
  end 
end