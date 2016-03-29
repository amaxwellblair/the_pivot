class UsersController < ApplicationController
  before_action :set_user, except: [:create, :new, :update]

  def create
    @user = User.new(user_params)
    @user.roles << Role.find_by(name: "registered_user")
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      flash[:danger] = "Invalid account details. Please try again."
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @orders = Order.all
    #TODO link order with store
    @stores = Store.all
    @categories = Category.all
  end

  def edit
    @user = current_user
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "Account successfully updated."
      redirect_to dashboard_path
    else
      flash[:danger] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :password,
                                 :first_name,
                                 :last_name,
                                 :address,
                                 :email)
  end

  def set_user
    @user = current_user
  end
end
