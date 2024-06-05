module FavoritesReportHelper
  # Returns whether the notes should be shown
  #
  # @return [Boolean] true, if the notes should be shown, false otherwise.
  def show_notes
    @report_option.show_notes
  end

  # Returns whether the keywords should be shown
  #
  # @return [Boolean] true, if the keywords should be shown, false otherwise
  def show_keywords
    @report_option.show_keywords
  end
end
