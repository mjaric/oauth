class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
  end

  def mycart
    begin
      @cart = current_cart
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cart }
      end
    end
  end
end
