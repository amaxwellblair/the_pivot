require "rails_helper"

RSpec.feature "store admin can create item" do
  scenario "can create item" do
    create_roles
    user = store_admin

    approved_store(user)

    login(user)

    create_categories

    click_on "Store Admin Information"

    create_item

    expect(page).to have_content "Carrots"
    expect(page).to have_content "$10.00"
  end
end
