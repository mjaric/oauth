class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :products, :through => :cart_items

  def total_price
    cart_items.to_a.sum(&:full_price)
  end

  def add_product(product_id)
    current_item = cart_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product_id)
    end
    current_item
  end

end
