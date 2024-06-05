# This represents a resource.
#
# A resource is a generic item from the TISS API.
#
# @!attribute [rw] id
#   @return [Integer] the id
# @!attribute [rw] title
#   @return [String] the title of this resource
# @!attribute [rw] _prefix
#   @return [String, nil] the prefix
# @!attribute [rw] addition
#   @return [String, nil] the addition
# @!attribute [rw] path
#   @return [String] the path
# @!attribute [rw] favorite
#   @return [Favorite, nil] the favorite
# @!attribute [rw] favorite_type
#   @return [favorite_type] the type of the favorite
# @!attribute [rw] keywords
#   @return [Array<Keyword>] the keywords
class Resource
  include ActiveModel::API

  attr_accessor :id, :title, :_prefix, :addition, :path, :favorite, :favorite_type, :keywords

  # Returns whether this resource is marked as favorite.
  #
  # @return [Boolean] true, if this is marked as favorite, false otherwise.
  def is_favorite?
    not @favorite.nil?
  end
end
