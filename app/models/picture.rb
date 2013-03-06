class Picture < ActiveRecord::Base
  belongs_to :product
  attr_accessible :image, :name, :product_id
  mount_uploader :image, ImageUploader

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => id,
      "picture_id" => id,
      "delete_type" => "DELETE"
    }
  end

end
