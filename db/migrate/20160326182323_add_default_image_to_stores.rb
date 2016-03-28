class AddDefaultImageToStores < ActiveRecord::Migration
  def change
    change_column_default :stores, :image_url, "http://www.plantation.org/wp-content/uploads/2013/02/farmers-mkt-shadow.jpg"
  end
end
