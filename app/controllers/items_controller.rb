class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.categories= Category.all.select {|category| params[category.title] == "1"}
    if @item.save
      flash[:success] = "#{@item.title} has been created!"
      redirect_to item_path(@item.id)
    else
      @categories = Category.all
      flash.now[:danger] = @item.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end
end
