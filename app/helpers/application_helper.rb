module ApplicationHelper
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def sorting(column, title = nil, dir = nil)
      title ||= column.titleize
      active = column == sort_column && dir == sort_direction ? 'active' : ''
      content_tag(:li, :class => active) do
        link_to title, {:sort => column, :direction => dir}
      end
  end

  def sort_info
    sort_column != 'id' ? t(sort_column) + ' ' + t(sort_direction) : t(:sort_by)
  end

  def format_price(price)
    number_to_currency(price, :unit => 'din', :separator => ',', :delimiter => '.', :format => '%n %u')
  end

  def nav_link(text, link)
    recognized = Rails.application.routes.recognize_path(link)
    #if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
    if recognized[:controller] == params[:controller]
        content_tag(:li, :class => "active") do
            link_to( text, link)
        end
    else
        content_tag(:li) do
            link_to( text, link)
        end
    end
  end

  def shorty(text, max = 50, dots = '...')
      if text.length >= max
        original_text = text
        index = text.rindex(' ', max)
        text = index == nil ? text.slice(0, max) : text.slice(0, index)
        text = raw ("<span title='#{original_text}'>" + text + dots + "</span>")
      end
      text
  end

end
