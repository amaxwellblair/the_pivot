require "rails_helper"

RSpec.feature "Store admin can see store admin dashboard" do
  scenario "can see store admin dashboard" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "store_admin")
    store = user.stores.create(name: "Farmer's Market")
    Category.create(
      title: "Root veg",
      image: "http://vegnews.com/web/uploads/asset/3143/file/featurette.rootvegetables.jpg"
    )
    store.items.create(
      id: 1000,
      title: "Carrot",
      description: "Lots of carrots everywhere!",
      price: 999,
      image: "https://s3.amazonaws.com/lucky2/cartoon_penny.png",
      categories: [Category.find_by(title: "Root veg")]
    )
    order = Order.create(user_id: user.id, status: "paid")

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    expect(current_path).to eq("/dashboard")

    click_on "Store Admin Information"

    expect(page).to have_content "##{order.id}"
    expect(page).to have_content "Carrot"
    expect(page).to have_content "$9.99"
  end
end
