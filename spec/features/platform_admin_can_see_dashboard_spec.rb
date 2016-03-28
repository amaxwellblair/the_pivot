require "rails_helper"

RSpec.feature "platfom admin can see platform admin dashboard" do
  scenario "can see dashboard" do
    create_roles
    user = platform_admin

    store = approved_store(user)

    login(user)

    expect(current_path).to eq("/dashboard")

    click_on "Platform Admin Information"

    expect(page).to have_content "#{store.name}"
    expect(page).to have_content "Approved"
  end
end
