require 'rails_helper'

RSpec.describe 'Logged out a User' do
  context 'displays log out instead of log in for a logged in User' do
    scenario 'A user logs out and is redirected to the home page' do
    u1 = User.create(name: "Sean Suga", email: "champ4lyfe@gmail.com", password: "champ", password_confirmation: "champ")

    visit root_path
    click_on 'I already have an account'

    fill_in :email, with: u1.email
    fill_in :password, with: u1.password

    click_button 'Log In'

    visit root_path

    page.has_no_link?('I already have an account')
    page.has_no_link?('Create New User')
    page.has_link?('Log Out') && page.click_link('Log Out')

    expect(current_path).to eq(root_path)

    page.has_link?('I already have an account')
    page.has_link?('Create New User')
    page.has_no_link?('Log Out')
    end
  end
end
