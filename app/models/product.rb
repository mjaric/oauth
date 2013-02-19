class Product < ActiveRecord::Base
  attr_accessible :title, :description, :category_id
  belongs_to :category
end
