class ReportOption
  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :show_notes, :boolean, default: true
  attribute :show_keywords, :boolean, default: true

  validates :show_notes, inclusion: { in: [true, false] }
  validates :show_keywords, inclusion: { in: [true, false] }
end
