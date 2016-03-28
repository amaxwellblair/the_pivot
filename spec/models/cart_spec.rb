require "rails_helper"

RSpec.describe "Cart", type: :model do
  before(:each) do
    create_integration
    @item = Item.last
    @cart = Cart.new({"3" => 3, "1" => 1})
  end

  it "can count items in cart" do
    expect(@cart.item_count).to eq(4)
  end

  it "can add items to cart" do
    status, message = @cart.update_quantity(false, @item)

    expect(status).to eq(:success)
    expect(message).to eq("1 #{@item.title} added to cart!")
    contents = { "3" => 3, "1" => 1, @item.id.to_s => 1 }
    expect(@cart.contents).to eq contents
  end

  it "can subtract items from cart" do
    @cart.update_quantity(false, @item)
    @cart.update_quantity(false, @item)

    status, message = @cart.update_quantity(true, @item)
    expect(status).to eq(:danger)
    expect(message).to eq("1 #{@item.title} removed from cart!")
    contents = {"3" => 3, "1" => 1, @item.id.to_s => 1}
    expect(@cart.contents).to eq contents
  end

  it "can create Item objects from its cart contents" do
    cart = Cart.new(@item.id.to_s => 4)
    items_with_quantity = cart.fetch_items
    item = items_with_quantity.first[0]
    quantity = items_with_quantity.first[1]

    expect(items_with_quantity.count).to eq 1
    expect(item.title).to eq @item.title
    expect(item.description).to eq @item.description
    expect(item.price).to eq @item.price
    expect(item.image.instance).to eq @item.image.instance
    expect(quantity).to eq 4
  end

  it "can calculate the total price of all cart items" do
    cart = Cart.new(@item.id.to_s => 4)
    expect(cart.total).to eq @item.price*4
  end
end
