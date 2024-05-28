# This is a {https://tiss.tuwien.ac.at TISS} API controller for projects.
class ProjectsController < TissApiController

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["project"], "search/projectFullSearch/v1.0/projects?searchterm=#{@search_term.query}")
    # TODO: capture result and parse course number and semester
  end

  # @see TissApiController#show
  def show
    @id = params["id"]
    super("pdb/rest/project/v3/#{@id}", -> (val) { Nokogiri::XML(val) })
  end

  protected

  def map_resources(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = @favorites&.find { |fav| fav.item_id == String(res["id"]) }
        map_resource(res, favorite, false)
      end
    end
  end

  def map_resource(res, favorite, is_single, keywords = nil)
    puts res

    if is_single
      res.remove_namespaces!
      id = @id
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
      path: project_path(id),
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
end
