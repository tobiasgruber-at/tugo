# This represents the options for a report.
# @!attribute [rw] show_notes
#   @return [Boolean] true, if the notes should be shown
# @!attribute [rw] show_keywords
#   @return [Boolean] true, if the keywords should be shown
class ReportOption
  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :show_notes, :boolean, default: true
  attribute :show_keywords, :boolean, default: true

  validates :show_notes, inclusion: { in: [true, false] }
  validates :show_keywords, inclusion: { in: [true, false] }
end
