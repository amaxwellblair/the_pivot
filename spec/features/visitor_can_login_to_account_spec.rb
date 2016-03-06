require "rails_helper"

RSpec.feature "visitor logs in" do
  context "enters valid username and password combination" do
    scenario "sees user dashboard page" do
      user = create(:user)
      visit "/"
      first(:link, "Login").click
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Login"

      expect(current_path).to eq "/dashboard"
      expect(page).to have_content("Logged in as #{user.username}")
      expect(page).to have_content("Your Orders")
      expect(page).to have_content("Logout")
      expect(page).to have_content("My Account")
      expect(page).to_not have_content("Login")
      expect(page).to_not have_content("Create Account")
    end
  end

  context "does not enter valid username and password combination" do
    scenario "gets error and sees login page again" do
      user = create(:user)
      visit "/"
      first(:link, "Login").click
      fill_in "Username", with: user.username
      fill_in "Password", with: "notmypassword"
      click_button "Login"

      expect(page).to have_content "Invalid login details. Please try again."
      expect(page).not_to have_content user.username
    end
  end

  context "visitor has items in cart before login" do
    scenario "sees items in cart" do
      category = create(:category_with_items)
      user = create(:user)

      visit "/items"
      category.items.each { |item| expect(page).to have_content(item.title) }

      within ".items" do
        first(:button, "Add to Cart").click
      end

      visit "/cart"
      expect(page).to have_content(category.items.first.title)

      click_on "Login"

      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_on "Login to your account"

      click_on "Cart"

      expect(page).to have_content(category.items.first.title)
      expect(page).to_not have_content(category.items[1].title)
      expect(page).to_not have_content(category.items.last.title)
    end
  end
end
