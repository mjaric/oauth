class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  attr_accessible :cart_id, :product_id

  before_create :default_quantity_to_one

  def unit_price
    product.price
  end

  def full_price
    unit_price*quantity
  end

  private

  def default_quantity_to_one
    self.quantity ||= 1
  end
end
