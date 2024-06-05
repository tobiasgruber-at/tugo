# This represents a project resource.
# @!attribute [rw] short_description
#   @return [String, nil] a short description of the project
# @!attribute [rw] contract_begin
#   @return [String, nil] the begin date of the contract
# @!attribute [rw] contract_end
#   @return [String, nil] the end date of the contract
# @!attribute [rw] project_begin
#   @return [String, nil] the begin date of the project
# @!attribute [rw] project_end
#   @return [String, nil] the end date of the project
class Project < Resource
  attr_accessor :short_description, :contract_begin, :contract_end, :project_begin, :project_end
end
