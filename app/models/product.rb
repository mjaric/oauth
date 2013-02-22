class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :category_id
  belongs_to :category
  has_many :pictures
  has_many :cart_items

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if cart_items.empty?
      true
    else
      errors.add(:base, 'Cart Items present')
      false
    end
  end

end
