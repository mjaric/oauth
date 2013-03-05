module ProductsHelper

    def product_image_tag(product, options = {})
        options[:size] ||= "300x200"

        if img = product.pictures.first
            image_tag(img.image_url(:thumb), :alt => img.name)
        else
            image_tag("http://placehold.it/#{options[:size]}", :size => options[:size])
        end
    end

end
