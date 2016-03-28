require "rails_helper"

RSpec.feature "visitor can create account" do
  context "enters valid username and password" do
    scenario "visitor logs in and sees dashboard" do
      create_roles

      visit "/"
      first(:link, "Create Account").click
      fill_in "Username", with: "brennan"
      fill_in "Password", with: "password"
      fill_in "First name", with: "Brennan"
      fill_in "Last name", with: "Holtzclaw"
      fill_in "Address", with: "1510 Blake Street, Basement"
      click_button "Create Account"

      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Logged in as brennan"
      expect(page).to have_content "Name: Brennan Holtzclaw"
      expect(page).to have_content "Address: 1510 Blake Street, Basement"
      expect(page).to have_content "All Orders"
      expect(page).to have_content "Logout"
      expect(page).not_to have_content "Login"
    end
  end

  context "enters an existing username" do
    scenario "sees error message and create account page" do
      create_roles
      user = registered_user

      visit "/"
      first(:link, "Create Account").click
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Create Account"

      expect(page).to have_content "Invalid account details. Please try again."
      expect(page).not_to have_content user.username
    end
  end
end
