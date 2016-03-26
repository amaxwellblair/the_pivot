class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::NumberHelper

  before_action :set_cart, :set_top_categories, :authorize!
  helper_method :current_user
  helper_method :format_price
  helper_method :user_orders_path

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize!
    render file: "public/404" unless authorize?
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def set_top_categories
    @top_categories ||= Category.take(4)
  end

  def format_price(price)
    number_to_currency(price.to_f / 100)
  end

  private

  def authorize?
    current_permission.allow?(params[:controller], params[:action])
  end

end
