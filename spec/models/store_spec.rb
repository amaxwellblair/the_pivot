require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :items }
  it { should belong_to :user }

  it "creates slug" do
    store = Store.create(name: "Farmer's Market")
    expect(store.slug).to eq "farmer-s-market"
  end
end
