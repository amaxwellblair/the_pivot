class AddDefaultStatusToStores < ActiveRecord::Migration
  def change
    change_column_default :stores, :status, 0
  end
end
