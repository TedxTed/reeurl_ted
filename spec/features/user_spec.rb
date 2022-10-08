# spec/features/user_spec.rb

# require 'rails_helper'

# RSpec.describe 'User', type: :system do
#   before(:all) do
#     Capybara.javascript_driver = :selenium_chrome
#   end
#   before :each do
#     User.create(email: 'user@example.com', password: 'password')
#   end
#   it "signs me in" do
#     visit root_path
#     click_link('登入')
#     within("#new_user") do
#       fill_in 'Email', with: 'user@example.com'
#       fill_in 'Password', with: 'password'
#     end
#     click_button 'Log in'
#     expect(page).to have_content 'successfully'
#   end
  
# end