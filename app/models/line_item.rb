class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  belongs_to :product

  attr_accessible :cart_id, :product_id, :order_id

  def unit_price
    product.price
  end

  def total_price
    unit_price*quantity
  end

end
