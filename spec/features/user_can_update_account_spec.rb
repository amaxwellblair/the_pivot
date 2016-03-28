require "rails_helper"

RSpec.feature "user can update an account" do
  context "user logs in and updates account" do
    scenario "sees user dashboard with updated information" do
      create_roles
      user = registered_user

      login(user)

      expect(current_path).to eq "/dashboard"

      click_on "Update Account"

      fill_in "Username", with: "Bacon"
      fill_in "First name", with: "Bacon Jr."
      fill_in "Last name", with: "Pokemon"
      fill_in "Password", with: "password"
      fill_in "Address", with: "1 fake ln, KY USA"
      fill_in "Email", with: "a@example.com"
      click_on "Update Account"

      expect(current_path).to eq "/dashboard"

      expect(page).to have_content "Bacon"
      expect(page).to have_content "Bacon Jr."
      expect(page).to have_content "Pokemon"
      expect(page).to have_content "1 fake ln, KY USA"
      expect(page).to have_content "a@example.com"
    end
  end
end
