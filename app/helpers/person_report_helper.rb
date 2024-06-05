module PersonReportHelper
  # Wraps all substrings in a given text and wraps them in a <mark> element, if they match a given regex.
  #
  # @return The highlighted string
  def highlight_regex(text, regex_pattern, highlighter = '<mark>\1</mark>')
    text.gsub(Regexp.new(regex_pattern, Regexp::IGNORECASE)) do |match|
      highlighter.gsub('\1', match)
    end.html_safe
  end
end
