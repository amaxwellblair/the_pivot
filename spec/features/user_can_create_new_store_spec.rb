require "rails_helper"

RSpec.feature "user can create a store" do
  context "user logs in and clicks create new store" do
    scenario "sees user dashboard page with new store listed" do
      create_roles
      user = registered_user

      login(user)

      expect(current_path).to eq "/dashboard"
      create_store(user)
      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Store successfully requested."

      click_on "Store Admin Information"

      expect(page).to have_content "#{user.first_name}'s Market"
      expect(page).to have_content "Status: Pending"
    end
  end
end
