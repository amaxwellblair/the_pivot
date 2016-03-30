require "rails_helper"

RSpec.feature "Store admin sees orders for only their store" do
  scenario "they see order for their store items and not other store's items" do
    create_roles
    user = registered_user
    user2 = store_admin
    user3 = store_admin2

    create_categories
    store = approved_store(user2)
    item_1 = item(store)
    store2 = approved_store2(user3)
    item_2 = item2(store2)

    login(user)
    visit items_path

    within ".navbar-right" do
      expect(page).to have_content "(0)"
    end

    visit store_item_path(store.slug, item_1.id)
    click_on "Add to Cart"

    visit store_item_path(store2.slug, item_2.id)
    click_on "Add to Cart"

    within ".navbar-right" do
      expect(page).to have_content "(2)"
      click_on "Cart"
    end

    click_on "Checkout"


  end
end
