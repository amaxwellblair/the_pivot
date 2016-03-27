require "rails_helper"

RSpec.feature "Store admin can delete store" do
  scenario "can see user dashboard without associated store" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    store = user.stores.create(name: "Farmer's Market")

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    expect(current_path).to eq("/dashboard")

    click_on "Store Admin Information"

    expect(page).to have_content "Farmer's Market"
    
    click_on "Delete store"
    expect(current_path).to eq("/dashboard")
    expect(page).not_to have_content "Store Admin Information"
  end
end
