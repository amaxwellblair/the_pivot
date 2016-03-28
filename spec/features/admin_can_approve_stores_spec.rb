require "rails_helper"

RSpec.feature "platform admin can approve a pending store" do
  scenario "can approve pending store" do
    create_roles
    user = platform_admin
    other_user = store_admin

    store = pending_store(other_user)

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    expect(page).to have_content store.name
    expect(page).to have_content "Pending"
    click_on "Approve"
    expect(page).to have_content "Approved"

    visit "/#{store.slug}"
    expect(current_path).to eq "/#{store.slug}"
  end

  scenario "can suspend approved store" do
    create_roles
    user = platform_admin
    other_user = store_admin

    store = approved_store(other_user)

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    expect(page).to have_content store.name
    expect(page).to have_content "Approved"
    click_on "Suspend"
    expect(page).to have_content "Suspended"

    visit "/#{store.slug}"
    expect(current_path).to_not eq("#{store.slug}")
  end
end
