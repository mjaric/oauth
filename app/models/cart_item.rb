class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  attr_accessible :cart_id, :product_id

  before_create :default_quantity_to_one

  def unit_price
    product.price
  end

  def total_price
    unit_price*quantity
  end

  private

  def default_quantity_to_one
    self.quantity ||= 1
  end
end
