# This is a {https://tiss.tuwien.ac.at TISS} API controller for projects.
class ProjectsController < TissApiController

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super("search/projectFullSearch/v1.0/projects?searchterm=#{@search_term.query}")
    # TODO: capture result and parse course number and semester
  end

  # @see TissApiController#show
  def show
    @id = params["id"]
    super("pdb/rest/project/v3/#{@id}", -> (val) { Nokogiri::XML(val) })
  end
end
