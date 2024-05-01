class ProjectsController < TissApiController

  def index
    term = params["term"]
    super(term, "search/projectFullSearch/v1.0/projects?searchterm=#{term}")
    # TODO: capture result and parse course number and semester
  end

  def show
    @id = params["id"]
    super("pdb/rest/project/v3/#{@id}", -> (val) { Nokogiri::XML(val) })
  end
end
