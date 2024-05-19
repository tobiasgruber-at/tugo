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

  protected

  def map_resources(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = @favorites&.find { |fav| fav.item_id == String(res["id"]) }&.id
        map_resource(res, favorite, false)
      end
    end
  end

  def map_resource(res, favorite, is_single)
    puts res

    if is_single
      res.remove_namespaces!
      id = @id
      title = res.css("title en").text
    else
      id = res["id"] || ""
      title = res["title"]
    end
    Resource.new(
      id,
      title,
      nil,
      nil,
      project_path(id),
      favorite,
      Favorite.favorite_types["project"]
    )
  end
end
