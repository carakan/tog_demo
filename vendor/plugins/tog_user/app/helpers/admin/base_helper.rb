module Admin
  module BaseHelper
	  # Return link to sort column with toggled sort order
	  def link_to_sortable_column_header(field, order_by, sort_order, name)
	    if order_by == field.to_s
	      sort_order = (sort_order || '').upcase == 'DESC' ? 'ASC' : 'DESC'
	      arrow = (sort_order == 'ASC') ? 'down' : 'up' 
	    else
	      sort_order = 'ASC'
	      arrow = nil
	    end
	    new_params = params.merge(:order_by => field.to_s, :sort_order => sort_order)
	    html = link_to(name, new_params)
	    html << image_tag("/tog_core/images/ico/arrow-#{arrow}.gif") if arrow
	    html
	  end
    
    # Insert exinsting params as hidden_fields
    def params_hidden_fields(params, ignore=['commit'])
      params.except(*ignore).map do |key, value|
        hidden_field_tag key, value unless value.blank?
      end.join
    end
	
    # Insert a li with link to filter
    #
    # Set field to nil to clear filter
    #
    # Options:
    #   :li_on: CSS class of <li> element if item is active (default: 'on')
    #
    def filter_item(field, value, remove_fields, name, options = {})
      on_condition = if field		
        params[field].to_s == value.to_s
      else
        remove_fields.all? { |field| params[field].blank? }
      end
      li_class = on_condition ? (options[:li_on] || 'on') : nil
      new_params = params.except('commit').except(*remove_fields)
      content_tag(:li, :class => li_class) do
        if value 
          link_to(name, new_params.merge(field => value.to_s))
        else
          link_to(name, new_params.except(field))
        end
      end
    end  
  end
end
