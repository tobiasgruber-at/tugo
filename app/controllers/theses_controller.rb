class ThesesController < TissApiController

  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["thesis"], "search/thesis/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  def show
    @id = params["id"]
    super("thesis/#{@id}", -> (val) { Nokogiri::XML(val) })
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

  def map_resource(res, favorite, is_single, keywords = nil)
    if is_single
      res.remove_namespaces!
      id = @id
      title = res.css("title *:last-of-type").text
    else
      id = res["id"] || ""
      title = res["title"]
    end
    Resource.new(
      id,
      title,
      nil,
      nil,
      thesis_path(id),
      favorite,
      Favorite.favorite_types["thesis"],
      keywords
    )
  end
end
