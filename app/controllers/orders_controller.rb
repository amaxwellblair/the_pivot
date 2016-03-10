class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders
    else
      redirect_to root_path
    end
  end

  def create
    @order = OrderGenerator.generate(@cart, current_user)
    if @order.save
      session[:cart] = {}
      flash[:success] = "Order was successfully placed!"
      if current_user.email
        UserNotifier.send_confirmation(current_user).deliver_now
        flash[:success] += " An email has been sent to: #{current_user.email}"
      end
      redirect_to order_path(@order.id)
    else
      flash.now[:danger] = "Checkout Error"
      render "/cart_items/index"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    flash[:success] = "Order ##{@order.id} has been #{@order.status}."
    redirect_to admin_dashboard_index_path
  end
end
