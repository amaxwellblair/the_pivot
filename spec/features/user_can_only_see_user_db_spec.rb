require "rails_helper"

RSpec.feature "user can only see user dashboard" do
  scenario "user does not see admin or platform admin dashboard" do
    create_roles
    user = registered_user

    login(user)

    expect(current_path).to eq "/dashboard"
    expect(page).to_not have_content "Store Admin Information"
  end
end
