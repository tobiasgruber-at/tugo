class FindTerm
  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :query, :string, default: ""

  validates :query, presence: true, allow_blank: true
end
