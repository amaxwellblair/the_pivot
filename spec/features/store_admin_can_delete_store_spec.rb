require "rails_helper"

RSpec.feature "Store admin can delete store" do
  scenario "can see user dashboard without associated store" do
    create_roles
    user = store_admin

    store = pending_store(user)

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Store Admin Information"
    expect(page).to have_content store.name

    click_on "Delete store"
    expect(current_path).to eq("/dashboard")
    expect(page).to have_content "Store has been successfully deleted."
    expect(page).not_to have_content store.name
    expect(page).not_to have_content "Store Admin Information"
  end
end
