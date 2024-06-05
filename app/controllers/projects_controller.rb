# This is a {https://tiss.tuwien.ac.at TISS} API controller for projects.
class ProjectsController < TissApiController

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["project"], "search/projectFullSearch/v1.0/projects?searchterm=#{@search_term.query}")
  end

  # @see TissApiController#show
  def show
    @id = params["id"]
    super("pdb/rest/project/v3/#{@id}", -> (val) { Nokogiri::XML(val) })
  end

  # Maps many projects to resources
  #
  # @param resources Resources to be mapped
  # @param favorites All favorites of the user
  # @param path_selector_fn Selects the details path for each single item
  # @return [void]
  def self.map_projects(resources, favorites, path_selector_fn)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = favorites&.find { |fav| fav.item_id == String(res["id"]) }
        ProjectsController.map_project(res, favorite, false, path_selector_fn, nil)
      end
    end
  end

  # Maps one project to a resource
  #
  # @param res The fetched project
  # @param favorite Favorite object, or null if it is no favorite
  # @param is_single Whether it was fetched in a list, or as a single item
  # @param path_selector_fn Selects the details path
  # @param id ID of the project
  # @param keywords Added keywords for this project
  # @return [void]
  def self.map_project(res, favorite, is_single, path_selector_fn, id, keywords = nil)
    if is_single
      res.remove_namespaces!
      title = res.css("title en").text
      short_description = res.css("shortDescription").text
      contract_begin = res.css("contractBegin").text
      contract_end = res.css("contractEnd").text
      project_begin = res.css("projectBegin").text
      project_end = res.css("projectEnd").text
    else
      id = res["id"] || ""
      title = res["title"]
      short_description = res["shortDescription"]
      contract_begin = res["contractBegin"]
      contract_end = res["contractEnd"]
      project_begin = res["projectBegin"]
      project_end = res["projectEnd"]
    end
    Project.new(
      id: id,
      title: title,
      _prefix: nil,
      addition: nil,
      path: path_selector_fn.call(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["project"],
      keywords: keywords,
      short_description: short_description,
      contract_begin: contract_begin,
      contract_end: contract_end,
      project_begin: project_begin,
      project_end: project_end
    )
  end

  protected

  # @see TissApiController#map_resources
  def map_resources(resources)
    ProjectsController.map_projects(resources, @favorites, -> (id) { project_path(id) })
  end

  # @see TissApiController#map_resource
  def map_resource(res, favorite, is_single, keywords = nil)
    ProjectsController.map_project(res, favorite, is_single, -> (id) { project_path(id) }, @id, keywords)
  end
end
