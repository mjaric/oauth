module ApplicationHelper
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def format_price(price)
    number_to_currency(price, :unit => 'din', :separator => ',', :delimiter => '.', :format => '%n %u')
  end

  def nav_link(text, link)
    recognized = Rails.application.routes.recognize_path(link)
    if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
        content_tag(:li, :class => "active") do
            link_to( text, link)
        end
    else
        content_tag(:li) do
            link_to( text, link)
        end
    end
end

end
