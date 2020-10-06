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
      visit '/discover'

      expect(page).to have_button('Top 40 Movies')

      click_button 'Top 40 Movies'

      expect(current_path).to eq('/discover/top-40')
    end

    it 'has form to search by movie title' do
      visit '/discover'

      fill_in :title, with: 'jumanji'

      click_button 'Search By Title'

      expect(current_path).to eq('/movie/find')
    end
  end
end
