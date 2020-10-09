require 'rails_helper'

RSpec.describe 'discover', type: :feature do
  describe 'page' do
    before :each do
      user = create :user

      visit '/'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_on 'Log in'
    end

    it 'has button to discover top 40 movies' do
      movies = MovieService.new
      @top_40 = movies.top_40

      visit '/discover'
      expect(page).to have_button('Top 40 Movies')

      click_button 'Top 40 Movies'

      expect(current_path).to eq('/movies')

      expect(@top_40.size).to eq(40)
      expect(page).to have_content("Gabriel's Inferno Part II")
      expect(page).to have_content("8.9")
    end

    it 'has form to search by movie title' do
      movies = MovieService.new
      @found_movies = movies.find('Hello')

      visit '/discover'

      fill_in :title, with: 'Hello'

      click_button 'Search By Title'

      expect(current_path).to eq('/movies')

      expect(@found_movies.size).to eq(40)
    end
    it 'returns notice if no movies found' do
      movies = MovieService.new
      @found_movies = movies.find('sdsfgwe')

      visit '/discover'

      fill_in :title, with: 'sdsfgwe'

      click_button 'Search By Title'

      expect(current_path).to eq('/movies')

      expect(page).to have_content('Sorry, no movies were found.')
      expect(@found_movies.size).to eq(0)
    end
  end
end
