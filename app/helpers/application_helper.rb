module ApplicationHelper

  def pluralize(size, singular, plural)
    if size == 1
      "#{size} #{singular}"
    else
      "#{size} #{plural}"
    end
  end

  def generate_breadcrumbs filter
    first_bread = I18n.t "#{property_name}.other"
    if filter
      second_bread = I18n.t "#{filter.keys[0]}.#{filter.values[0]}"
      @listing_title = "Vendas / #{first_bread} / #{second_bread}"
    else
      @listing_title = "Vendas / #{first_bread}"
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
