class Stores::ItemsController < Stores::StoresController

  def index
    @items = current_store.items
  end

  def show
    @item = current_store.items.find_by(id: params[:id])
  end
end
