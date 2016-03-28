# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'


def create_roles
  %w(registered_user store_admin platform_admin).each do |role|
    Role.create(name: role)
  end
end

def registered_user
  registered_user = User.create(username: "nonaps",
                        password: "password",
                        first_name: "Nick",
                        last_name: "Dorans",
                        email: "bdiddybreeze@yahoo.com",
                        address: "Bayonne NJ")
  registered_user.roles << Role.find_by(name: "registered_user")
  registered_user
end

def store_admin
  store_admin = User.create(username: "store",
                                 password: "password",
                                 first_name: "sto",
                                 last_name: "re",
                                 email: "store@store.co",
                                 address: "Denver CO")
  store_admin.roles << Role.find_by(name: "registered_user")
  store_admin.roles << Role.find_by(name: "store_admin")
  store_admin
end

def platform_admin
  platform_admin = User.create(username: "admin",
                              password: "password",
                              first_name: "admin",
                              last_name: "admin",
                              email: "admin@turing.io",
                              address: "Denver CO",
                              )
  platform_admin.roles << Role.find_by(name: "registered_user")
  platform_admin.roles << Role.find_by(name: "platform_admin")
  platform_admin
end

def pending_store(user)
  user.stores.create(name: "Mod Market",
               description: "Modern times calls for modern Markets..",
               status: 0)
end

def approved_store(user)
  user.stores.create(name: "Approved",
               description: "We just got approved ya'll",
               status: 2)
end

def suspended_store(user)
  user.stores.create(name: "Suspended",
               description: "We were bad and now we're suspended..",
               status: 1)
end

def create_categories
  %w(Fruits Vegetables Greens).each do |category|
    Category.create(title: category)
  end
end

def item(store)
  store.items.create(title: "Celery",
              description: "Green, crunchy, delicious!",
              price: 1000,
              categories: [Category.find_by(title: "Vegetables")])
end

def item2(store)
  store.items.create(title: "Carrots",
              description: "Orange, crunchy",
              price: 500,
              categories: [Category.find_by(title: "Vegetables")])
end

def item3(store)
  store.items.create(title: "Apples",
              description: "Honey Crisp - engineered greatness!",
              price: 800,
              categories: [Category.first])
end

def item4(store)
  store.items.create(title: "Arugula",
              description: "It's green and peppery",
              price: 900,
              categories: [Category.last])
end

def create_store(user)
  click_on "Create new store"
  fill_in "Name", with: "#{user.first_name}'s Market"
  fill_in "Description", with: "#{user.first_name} says this place is great!"
  click_button "Submit"
end

def create_item
  click_on "Create item"
  fill_in "Title", with: "Carrots"
  fill_in "Description", with: "Yum yum!"
  fill_in "Price", with: 1000
  check "Fruits"
  click_on "Create Item"
end

def login(user)
  visit "/login"
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_on "Login to your account"
end

def create_integration
  create_categories
  create_roles
  user = registered_user
  store = approved_store(user)
  item(store)
  item2(store)
end



ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end


  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end


  config.before(:each) do
    DatabaseCleaner.start
  end


  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
