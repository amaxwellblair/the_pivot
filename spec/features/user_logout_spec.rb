require "rails_helper"

RSpec.feature "User logs out of account" do
  scenario "user turns visitor and sees logout link change" do
    User.create(username: "brennan", password: "password")

    visit "/"
    first(:link, "Login").click

    fill_in "Username", with: "brennan"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")

    click_on "Logout"

    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end

  # context "has items in cart when logging out" do
  #   scenario "sees items in cart" do
  #     user = create(:user)
  #     item1 = create(:item)
  #     visit "/"
  #     first(:link, "Login").click
  #     fill_in "Username", with: user.username
  #     fill_in "Password", with: "password"
  #     click_on "Login to your account"
  #     visit "/items"
  #     click_on "Add to Cart"
  #     click_on "Add to Cart"
  #     expect(page).to have_content "Cart (2)"
  #     click_on "Logout"
  #     visit "/cart"
  #
  #     within(".cart-items") do
  #       expect(page).to have_content item1.title
  #       expect(page).to have_content "$0.01"
  #       expect(page).to have_content "Qty. 2"
  #       expect(page).to have_content "Subtotal: $0.02"
  #     end
  #     expect(page).to have_content "Total: $0.02"
  #   end
  # end
end
