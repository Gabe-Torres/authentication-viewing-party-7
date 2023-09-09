require 'rails_helper'

RSpec.describe 'Viewing Party Authorization' do
  context 'I try to create a viewing party as a visitor' do
    scenario 'I am redirected to the movie show page' do
      movie = Movie.create!(title: 'The Lion Man Returns 2.5 Extended Version', rating: 4, description: 'TESt')
      puts "Movie id: #{movie.id}"
      visit movie_path(movie)
      # save_and_open_page
      click_button 'Create Viewing Party'
      expect(current_path).to eq(movie_path(movie))
      expect(page).to have_content('You must be logged in or registered to create a viewing party.')
    end
  end
end
