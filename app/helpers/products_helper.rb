module ProductsHelper

    def product_image_tag(product, options = {})
        options[:size] ||= "300x200"

        picture = product.default_picture_id ? product.pictures.find(product.default_picture_id) : product.pictures.first

        if picture
            image_tag(picture.image_url(:thumb), :alt => picture.name)
        else
            image_tag("http://placehold.it/#{options[:size]}", :size => options[:size])
        end
    end

    def product_thumbanil_tag(product, options = {})
        options[:size] ||= "300x200"

        picture = product.default_picture_id ? product.pictures.find(product.default_picture_id) : product.pictures.first

        if picture
            content_tag(:div, content_tag(:span, ''), :class => 'thumbnail default-picture', :style => "background-image: url(#{picture.image_url(:thumb)})")
            #image_tag(picture.image_url(:thumb), :alt => picture.name)
        else
            image_tag("http://placehold.it/#{options[:size]}", :size => options[:size])
        end
    end

end
