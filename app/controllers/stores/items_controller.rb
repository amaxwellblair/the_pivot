class Stores::ItemsController < Stores::StoresController

  def index
    redirect_to root_path if current_store.pending? || current_store.suspended?
    @items = current_store.items
  end

  def show
    @item = current_store.items.find_by(id: params[:id])
  end

  def new
    @item = current_store.items.new
    @categories = Category.all
  end

  def create
    @item = current_store.items.new(item_params)
    @categories = Category.all
    @item.categories = Category.all.select do |category|
      params[category.title] == "1"
    end
    if @item.save
      flash[:success] = "Item successfully created!"
      redirect_to dashboard_path(tab: "store_info")
    else
      flash.now[:danger] = @item.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @item = current_store.items.find_by(id: params[:id])
    @categories = Category.all
  end

  def update
    @item = current_store.items.find_by(id: params[:id])
    @categories = Category.all
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated successfully."
      redirect_to dashboard_path
    else
      flash.now[:danger] = @item.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:alert] = "Item has been successfully deleted."
    redirect_to dashboard_path
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :categories)
    end
end
