FactoryGirl.define do
  factory :user_role do
    user nil
    role nil
  end
  factory :role do
    name
  end
  factory :store do
    name "MyString"
    slug "MyString"
  end
  factory :line_item do
    order nil
    item nil
    quantity 1
  end
  factory :order do
    status "MyString"
    user nil
  end

  factory :user do
    username "janedoe"
    password "password"
    first_name "Jane"
    last_name "Doe"
    address "1510 Blake St., Denver, CO, 80202"

    factory :user_with_roles do

    end
  end
  factory :category do
    title

    factory :category_with_items do
      items { create_list(:item, 3) }
    end
  end

  sequence :name, %w(registered_user store_admin platform_admin).cycle do |name|
    "#{name}"
  end

  sequence :title, %w(1 2 3).cycle do |name|
    "#{name}"
  end

  sequence :item_name, %w(1 2 3 4 5 6).cycle do |number|
    "Lucky Item #{number}"
  end

  sequence :description, %w(1 2 3).cycle do |number|
    "#{number} description"
  end

  sequence :category, %w(1 2 3).cycle do |number|
    "Category #{number}"
  end

  factory :item do
    title { generate(:item_name) }
    description
    price 1
    categories { create_list(:category, 1) }
    image "https://s3.amazonaws.com/lucky2/lucky_test.png"
  end
end
