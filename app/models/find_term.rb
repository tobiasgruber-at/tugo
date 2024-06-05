# This represents a term used to find something on a page.
# @!attribute [rw] query
#   @return [String] the query
class FindTerm
  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :query, :string, default: ""

  validates :query, presence: true, allow_blank: true
end
