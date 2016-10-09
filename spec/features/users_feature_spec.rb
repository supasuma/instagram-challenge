require 'rails_helper'

feature 'users can sign in and out' do

  context "user not signed in and on the homepage" do

    it "should see a 'Login' link and a 'Register' link and no 'Logout'" do
      visit('/')
      expect(page).to have_link('Login')
      expect(page).to have_link('Register')
      expect(page).not_to have_link('Logout')
    end
  end

  context "new user registering on homepage" do

    it "should not see a 'Login'/'Register' links, should see logout and success message" do
      sign_up_new_user
      expect(page).to have_content('Welcome! You have signed up successfully')
      expect(page).to have_link('Logout')
      expect(page).not_to have_link('Login')
      expect(page).not_to have_link('Register')
    end
  end

  context "user logging in on homepage" do

    it "should not see a 'Login'/'Register' links, should see logout and success message" do
      sign_up_new_user
      click_link('Logout')
      user_login
      expect(page).to have_content('Signed in successfully')
      expect(page).to have_link('Logout')
      expect(page).not_to have_link('Login')
      expect(page).not_to have_link('Register')
    end
  end



end
