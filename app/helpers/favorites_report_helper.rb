module FavoritesReportHelper
  # @return Whether notes should be shown
  def show_notes
    @report_option.show_notes
  end

  # @return Whether keywords should be shown
  def show_keywords
    @report_option.show_keywords
  end
end
