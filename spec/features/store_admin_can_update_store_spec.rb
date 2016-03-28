require "rails_helper"

RSpec.feature "Store admin can update store" do
  scenario "can see user dashboard with updated store info" do
    create_roles
    user = store_admin

    store = pending_store(user)

    login(user)

    expect(current_path).to eq "/dashboard"

    click_on "Store Admin Information"

    expect(page).to have_content store.name
    click_on "Update store"
    fill_in "Name", with: "Modern Farmers"
    click_button "Submit"
    expect(current_path).to eq "/dashboard"
    expect(page).not_to have_content store.name
    expect(page).to have_content "Modern Farmers"
  end
end
