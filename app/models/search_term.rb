# This represents a search.
#
# This search contains a query, that is searched for.
# @!attribute [rw] query
#   @return [String] the search query
class SearchTerm
  include ActiveModel::API

  attr_accessor :query

  # The search requires a query, that is at least three characters long.
  validates :query, presence: true, length: { minimum: 3 }
end
