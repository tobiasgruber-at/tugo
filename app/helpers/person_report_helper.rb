module PersonReportHelper
  # Performs {ActionView#Helpers#TextHelper#highlight}, if the condition is true, else it will output the given text.
  # The highlighting is always case insensitive.
  #
  # @param [Boolean] condition if true, the given text will be highlighted
  # @param [String] text the text to be searched
  # @param [String] regex_pattern the regex pattern
  # @return [String] the highlighted string if condition is true, text otherwise
  def highlight_regex_if(condition, text, regex_pattern)
    if condition and not regex_pattern.nil? and not regex_pattern.blank?
      highlight(text, Regexp.new(regex_pattern, Regexp::IGNORECASE))
    else
      text
    end
  end
end
