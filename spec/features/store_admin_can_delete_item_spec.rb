require "rails_helper"

RSpec.feature "Store admin can delete items" do
  scenario "they see dashboard without deleted item" do
    create_roles
    user = store_admin

    store = approved_store(user)

    create_categories

    item2(store)

    login(user)

    click_on "Store Admin Information"
    expect(page).to have_content "Carrots"
    click_on "Delete Item"
    expect(page).to have_content "Item has been successfully deleted."
    expect(page).not_to have_content "Carrots"
  end
end
