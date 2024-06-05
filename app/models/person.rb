# This represents a person.
# @!attribute [rw] titles_pre
#   @return [String, nil] prefix titles
# @!attribute [rw] titles_post
#   @return [String, nil] postfix titles
# @!attribute [rw] phone
#   @return [String, nil] phone number
# @!attribute [rw] email
#   @return [String, nil] the main email address
class Person < Resource
  attr_accessor :titles_pre, :titles_post, :phone, :email
end
