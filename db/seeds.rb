def create_roles
  %w(registered_user store_admin platform_admin).each do |role|
    role = Role.create(name: role)
    puts "Created #{role.name}"
  end
end

def create_categories
  %w(Organic Gluten-free Vegan Low-fat Local Free-range GMO Grass-fed Paleo Kosher).each do |category|
    category = Category.create(title: category, created_at: Time.now, image: "http://cdn.theatlantic.com/static/mt/assets/food/4182898562_cfcf720592_b_wide.jpg")
    puts "Created #{category.title}"
  end
end

def create_registered_users
  while User.joins(:roles).where("roles.name" => "registered_user").count < 99
    user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: address, roles: [Role.find(1)])
    puts "Created #{user.username}"
  end
  usr = User.create(username: "josh_mejia", password: "password", email: "josh@turing.io", first_name: "josh", last_name: "mejia", address: address, roles: [Role.find(1)])
  puts "Created #{user.username}"
end

def create_store_admin
  while User.joins(:roles).where("roles.name" => "store_admin").count < 19
    user = User.create(username: Faker::Internet.user_name, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: address, roles: [Role.find(1), Role.find(2)])
    puts "Created #{user.username}"
  end
  User.create(username: "andrew_carmer", password: "password", email: "andrew@turing.io", first_name: "andrew", last_name: "carmer", address: address, roles: [Role.find(1), Role.find(2)])
  puts "Created #{user.username}"
end

def create_platform_admin
  # Included in case other platform admins will be created
  while User.joins(:roles).where("roles.name" => "platform_admin").count < 0
    user = User.create(username: Faker::Internet.user_name, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: address, roles: [Role.find(1), Role.find(3)])
    puts "Created #{user.username}"
  end
  user = User.create(username: "jorge_tellez", password: "password", email: "jorge@turing.io", first_name: "jorge", last_name: "tellez", address: address, roles: [Role.find(1), Role.find(3)])
  puts "Created #{user.username}"
end

def create_store(user, category)
  store = user.stores.create(name: Faker::Company.name + " Market", status: 2)
  file = File.open("#{Rails.root}/app/assets/images/danger_beet.jpg")
  while store.items.count < 25
    create_item(store, category, file)
  end
end

def create_item(store, category, image)
  item = store.items.create(title: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(3), price: Faker::Commerce.price.to_i * 10**2 , image: image, categories: [category])
  puts "Created #{item.title}."
end

def address
  Faker::Address.street_address + " " + Faker::Address.city + ", " + Faker::Address.state + " USA"
end

def create_users
  create_registered_users
  create_store_admin
  create_platform_admin
end

def seed
  create_roles
  create_categories
  create_users

  store_admins = User.joins(:roles).where("roles.name" => "store_admin").to_a
  Category.all.each do |category|
    create_store(store_admins.pop, category)
    create_store(store_admins.pop, category)
  end
end

seed
