require "rails_helper"

RSpec.feature "Store admin can see store admin dashboard" do
  scenario "can see store admin dashboard" do
    create_roles
    user = store_admin

    store = pending_store(user)

    create_categories

    item2(store)

    order = Order.create(user_id: user.id, status: "paid")

    login(user)

    expect(current_path).to eq("/dashboard")

    click_on "Store Admin Information"

    expect(page).to have_content "##{order.id}"
    expect(page).to have_content "Carrots"
    expect(page).to have_content "$5.00"
  end
end
