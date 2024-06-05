# This represents a thesis resource
# @!attribute [rw] institute
#   @return [String, nil] the institute
# @!attribute [rw] faculty
#   @return [String, nil] the faculty
# @!attribute [rw] thesis_keywords
#   @return [String, nil] the thesis keywords
# @!attribute [rw] url
#   @return [String] the url for the thesis
class Thesis < Resource
  attr_accessor :institute, :faculty, :thesis_keywords, :url
end
