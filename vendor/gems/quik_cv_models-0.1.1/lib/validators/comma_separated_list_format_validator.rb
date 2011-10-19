class CommaSeparatedListFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value.blank?
      comma_separated_pattern = /^(\D+,?\s?)*/
      unless value == value[comma_separated_pattern]
        object.errors[attribute] << (options[:message] || "should be a comma separated list")
      end
    end
  end
end