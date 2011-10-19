require "active_model"
class IsDateFormatValidator < ActiveModel::EachValidator
  
  def validate_each(object, attribute, value)
    begin
      Date.parse value.to_s :long
    rescue ArgumentError
      object.errors[attribute] << (options[:message] || "is not a valid date")
    end
  end
end