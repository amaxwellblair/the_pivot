require "rails_helper"

RSpec.feature "Store admin can update items" do
  scenario "they see updated info" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    store = user.stores.create(name: "Farmer's Market")
    store.status = 2
    category = Category.create(title: "food", id: 1000)
    item = store.items.create(title: "carrots", description: "tasty", price: 999, categories: [category], id: 1001)

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    click_on "Store Admin Information"
    click_on "Update Item"
    fill_in "Title", with: "broccoli"
    fill_in "Description", with: "So green"
    fill_in "Price", with: 1000
    click_on "Update Item"

    expect(page).to have_content "broccoli"
    expect(page).to have_content "$10.00"
    expect(page).to have_content "Item updated successfully."
  end
end
