class HomesController < ApplicationController

  def show
    @items      = Item.take(3)
    @stores     = Store.take(3)
    @categories = Category.take(3)
  end
end
