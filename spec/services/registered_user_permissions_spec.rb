require 'rails_helper'

RSpec.describe "Registered User Permissions" do
  before(:each) do
    3.times{create(:role)}
    @user = create(:user)
    @user.roles << Role.find_by(name: "registered_user")
  end

  scenario "homes#show" do
    permission = Permission.new(@user, 'homes', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "stores#new" do
    permission = Permission.new(@user, 'stores', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "stores#create" do
    permission = Permission.new(@user, 'stores', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "stores#index" do
    permission = Permission.new(@user, 'stores', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "stores#show" do
    permission = Permission.new(@user, 'stores', 'show')
    result = permission.allow?
    expect(result).to be true
  end
end
