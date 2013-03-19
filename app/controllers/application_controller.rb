class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'public'
  #before_filter :store_location

  helper_method :current_cart, :sort_column, :sort_direction

  private

  # Devise: Where to redirect users once they have logged in
  def after_sign_in_path_for(resource)
    @final_url = root_path
    if current_user.admin?
      @final_url = admin_products_path
    end
    session[:previous_url] || @final_url    
    #@final_url    
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  # Initialize cart
  def current_cart
    Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def sort_column
      logger.debug('model_class')
      controller_name.singularize.classify.constantize.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

end
