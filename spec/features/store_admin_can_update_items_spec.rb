require "rails_helper"

RSpec.feature "Store admin can update items" do
  scenario "they see updated info" do
    create_roles
    user = store_admin

    store = approved_store(user)

    create_categories

    item2(store)

    login(user)

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
