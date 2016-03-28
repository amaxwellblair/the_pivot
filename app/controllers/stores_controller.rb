class StoresController < ApplicationController

  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = current_user.stores.new(store_params)
    if @store.save
      current_user.roles << Role.find_by(name: "store_admin")
      flash[:success] = "Store successfully requested."
      redirect_to dashboard_path
    else
      flash.now[:danger] = @store.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    @store = Store.find(params[:id])
    if current_user.platform_admin? && params[:status]
      @store.status = params[:status].to_i
      if @store.save
        flash[:alert] = "Store successfully updated."
      else
        flash.now[:danger] = @store.errors.full_messages.join(", ")
      end
      redirect_to dashboard_path
    else
      @store.update_attributes(store_params)
      if @store.save
        flash[:alert] = "Store successfully updated."
        redirect_to dashboard_path
      else
        flash.now[:danger] = @store.errors.full_messages.join(", ")
        render :edit
      end
    end
  end

  def destroy
    current_user.stores.first.destroy
    UserRole.where(user_id: current_user.id).find_by(role_id: Role.find_by(name: "store_admin").id).destroy
    flash[:success] = "Store has been successfully deleted."
    redirect_to dashboard_path
  end

  private

    def store_params
      params.require(:store).permit(:name, :description, :image_url)
    end
end
