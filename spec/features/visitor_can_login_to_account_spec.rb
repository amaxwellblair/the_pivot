require "rails_helper"

RSpec.feature "visitor logs in" do
  context "enters valid username and password combination" do
    scenario "sees user dashboard page" do
      create_roles
      user = registered_user

      login(user)

      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Logged in as #{user.username}"
      expect(page).to have_content "All Orders"
      expect(page).to have_content "Logout"
      expect(page).to have_content "My Account"
      expect(page).to_not have_content "Login"
      expect(page).to_not have_content "Create Account"
    end
  end

  context "does not enter valid username and password combination" do
    scenario "gets error and sees login page again" do
      create_roles
      user = registered_user

      visit "/"
      first(:link, "Login").click
      fill_in "Username", with: user.username
      fill_in "Password", with: "notmypassword"
      click_button "Login"

      expect(page).to have_content "Invalid login details. Please try again."
      expect(page).not_to have_content user.username
    end
  end

  # context "visitor has items in cart before login" do
  #   scenario "sees items in cart" do
  #     item1 = create(:item)
  #     user = create(:user)
  #
  #     visit "/items"
  #
  #     expect(page).to have_content item1.title
  #
  #     within ".items" do
  #       first(:button, "Add to Cart").click
  #     end
  #
  #     visit "/cart"
  #     expect(page).to have_content(item1.title)
  #
  #     click_on "Login"
  #
  #     fill_in "Username", with: user.username
  #     fill_in "Password", with: "password"
  #     click_on "Login to your account"
  #
  #     click_on "Cart"
  #
  #     expect(page).to have_content(item1.title)
  #   end
  # end
end
