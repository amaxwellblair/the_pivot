require "rails_helper"

RSpec.feature "platfom admin can see platform admin dashboard" do
  scenario "can see dashboard" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "platform_admin")
    store = Store.create(name: "Farmer's Market")

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    expect(current_path).to eq("/dashboard")

    click_on "Platform Admin Information"

    expect(page).to have_content "#{store.name}"
    expect(page).to have_content "Available"
  end
end
