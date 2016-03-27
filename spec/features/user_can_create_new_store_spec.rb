require "rails_helper"

RSpec.feature "user can create a store" do
  context "user logs in and clicks create new store" do
    scenario "sees user dashboard page with new store listed" do
      user = User.create(username: "bacon", password: "password")
      3.times{create(:role)}
      user.roles << Role.first

      visit "/"
      first(:link, "Login").click
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Login"

      expect(current_path).to eq "/dashboard"
      click_on "Create new store"
      fill_in "Name", with: "Mod Farmers"
      fill_in "Description", with: "This place is great"
      click_button "Create store"
      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Store successfully requested."

      click_on "Store Admin Information"

      expect(page).to have_content "Mod Farmers"
      expect(page).to have_content "Status: pending"
    end
  end
end
