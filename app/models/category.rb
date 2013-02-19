class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :name, :description, :parent_id
  attr_protected :lft, :rgt, :depth

  has_many :products
end
