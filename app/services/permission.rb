class Permission
  extend Forwardable

  def_delegators :user,
    :platform_admin?,
    :store_admin?,
    :registered_user?

  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def allow?
    case
    when platform_admin?
      platform_admin_permissions
    when store_admin?
      store_admin_permissions
    when registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private
    def user
      @user
    end

    def controller
      @controller
    end

    def action
      @action
    end

    def platform_admin_permissions
      return true if controller == 'homes' && action.in?(%w(show))
      return true if controller == 'stores' && action.in?(%w(index new create show update destroy))
      return true if controller == 'stores/items' && action.in?(%w(index new show))
      return true if controller == 'orders' && action.in?(%w(index create show update))
      return true if controller == 'users' && action.in?(%w(show edit update))
      return true if controller == 'sessions' && action.in?(%w(new create destroy))
    end

    def store_admin_permissions
      return true if controller == 'homes' && action.in?(%w(show))
      return true if controller == 'stores' && action.in?(%w(index show edit update destroy))
      return true if controller == 'stores/items' && action.in?(%w(index new create show edit update destroy))
      return true if controller == 'orders' && action.in?(%w(index create show update))
      return true if controller == 'cart_items' && action.in?(%w(index create destroy))
      return true if controller == 'users' && action.in?(%w(show edit update))
      return true if controller == 'sessions' && action.in?(%w(new create destroy))
    end

    def registered_user_permissions
      return true if controller == 'homes' && action.in?(%w(show))
      return true if controller == 'stores' && action.in?(%w(new create index show))
      return true if controller == 'stores/items' && action.in?(%w(index new create))
      return true if controller == 'orders' && action.in?(%w(index create show update))
      return true if controller == 'cart_items' && action.in?(%w(index create destroy))
      return true if controller == 'users' && action.in?(%w(show edit update))
      return true if controller == 'sessions' && action.in?(%w(new create destroy))
    end

    def guest_user_permissions
      return true if controller == 'homes' && action.in?(%w(show))
      return true if controller == 'stores' && action.in?(%w(index show))
      return true if controller == 'stores/items' && action.in?(%w(index))
      return true if controller == 'cart_items' && action.in?(%w(index create destroy))
      return true if controller == 'users' && action.in?(%w(new create))
      return true if controller == 'sessions' && action.in?(%w(new create destroy))
    end
end
