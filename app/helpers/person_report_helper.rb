module PersonReportHelper
  # Wraps all substrings in a given text and wraps them in a <mark> element,
  # if they match a given regex.
  #
  # @param [String] text the text to be searched
  # @param [String] regex_pattern the regex pattern
  # @param [String] highlighter the replacement
  # @return [String] the highlighted string
  def highlight_regex(text, regex_pattern, highlighter = "<mark>\1</mark>")
    text.gsub(Regexp.new(regex_pattern, Regexp::IGNORECASE)) do |match|
      highlighter.gsub("\1", match)
    end.html_safe
  end

  # TODO add link to other method
  # Performs :highlight_regex, if the condition is true, else it will output the given text.
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
