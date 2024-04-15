class SearchTerm
  include ActiveModel::API

  attr_accessor :query
  validates :query, presence: true, length: { minimum: 3 }
end
