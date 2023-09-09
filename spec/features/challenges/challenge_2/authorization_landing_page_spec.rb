require 'rails_helper'

RSpec.describe 'Landing Page Authorization' do
  context 'I visit the landing page as a visitor' do
    scenario 'I should not see a list of existing users' do
      # u1 = User.create(name: 'Sean Suga', email: 'champ4lyfe@gmail.com', password: 'champ', password_confirmation: 'champ', role: 0)

      visit root_path

      # expect(page).to_not have_content(u1.name)
      expect(page).to_not have_content('Existing Users')
    end
  end
  context 'I visit the landing page as a registered user' do
    before :each do
      @user1 = User.create(name: 'User One', email: 'user1@test.com', password: 'password', password_confirmation: 'password', role: 1)
      @user2 = User.create(name: 'User Two', email: 'user2@test.com', password: 'password', password_confirmation: 'password', role: 1)

      visit root_path
      click_on 'I already have an account'

      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password

      click_on 'Log In'
    end
    scenario 'the list of exisiting users is now emails' do
      expect(page).to have_content('Existing Users:')
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end
  end
end
