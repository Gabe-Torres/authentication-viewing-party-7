require 'rails_helper'

RSpec.describe 'Admin Login' do
context 'Admin Login happy path' do 
    scenario 'I can log in as an admin and get to my dashboard' do 
        admin = User.create!(name: 'SeanSuga', email: "suga@gmail.com",
                          password: "password", password_confirmation: "password",
                          role: 2)
  
        visit login_path
        fill_in :email, with: admin.email
        fill_in :password, with: admin.password
        # fill_in 'user[password_confirmation, with: admin.password
        click_on "Log In"
  
        expect(current_path).to eq(admin_dashboard_path)
      end
    end
  
  describe "as default user" do
    it 'does not allow default user to see admin dashboard index' do
      user = User.create!(name: 'Bobb', email: "COrn@gmail.com",
                         password: "password", password_confirmation: "password",
                         role: 0)
  
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  
      visit admin_dashboard_path
  
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end