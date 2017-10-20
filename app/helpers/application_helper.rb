module ApplicationHelper

  def square_meters value
    "#{number_with_precision(value, precision: 2)} m²"
  end

  def pluralize(size, singular, plural)
    if size == 1 then "#{size} #{singular}" else "#{size} #{plural}" end
  end

  def generate_breadcrumbs filter
    first_crumb = I18n.t "views.#{property_name}.other"
    if filter
      second_crumb = I18n.t "views.#{filter.keys[0]}.#{filter.values[0]}"
      @listing_title = "Vendas / #{first_crumb} / #{second_crumb}"
    else
      @listing_title = "Vendas / #{first_crumb}"
    end
  end

  def error_message_for_field(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        render "partials/error_message_for_field",
        message: object.errors.messages[field_name].first
      end
    end
  end

  def validate_field(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        return "is-invalid"
      end
    end
    return ""
  end

end
