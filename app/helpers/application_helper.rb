module ApplicationHelper

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
