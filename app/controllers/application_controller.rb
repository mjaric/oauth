class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  # Devise: Where to redirect users once they have logged in
  def after_sign_in_path_for(resource)
    @final_url = root_path
    if current_user.admin?
      @final_url = admin_products_path
    end
    @final_url
  end

  private

  # Initialize cart
  def current_cart
    session[:cart_id] ||= Cart.create!.id
    @current_cart ||= Cart.find(session[:cart_id])
  end

end
