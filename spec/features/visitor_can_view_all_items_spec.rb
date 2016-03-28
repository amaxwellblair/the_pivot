require "rails_helper"

RSpec.feature "Visitor can view all items" do
  scenario "they see all items" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    store = user.stores.create(name: "Farmer's Market")
    store.status = 2
    category = Category.create(title: "food", id: 1000)
    item = store.items.create(title: "carrots", description: "tasty", price: 999, categories: [category], id: 1001)

    visit root_path
    click_on "Items"
    expect(current_path).to eq(items_path)
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content "$9.99"
    expect(page).to have_button "Add to Cart"

    click_on "#{item.title}"
    expect(current_path).to eq(store_item_path(item.store.slug, item.id))
    expect(page).to have_content "#{store.name}"
  end
end
