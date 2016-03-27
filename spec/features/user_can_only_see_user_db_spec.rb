require "rails_helper"

RSpec.feature "user can only see user dashboard" do
  scenario "user does not see admin or platform admin dashboard" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.first

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    expect(current_path).to eq "/dashboard"
    expect(page).to_not have_content "Store Admin Information"
  end
end
