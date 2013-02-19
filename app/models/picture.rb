class Picture < ActiveRecord::Base
  belongs_to :product
  attr_accessible :image, :name, :product_id
  mount_uploader :image, ImageUploader
end
