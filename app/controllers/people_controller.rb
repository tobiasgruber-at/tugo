# This is a {https://tiss.tuwien.ac.at TISS} API controller for people.
class PeopleController < TissApiController

  def initialize
    super
    @endpoint_base = "person/v22/"
  end

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super("psuche?q=#{@search_term.query}&max_treffer=100")
  end

  # @see TissApiController#show
  def show
    id = params["id"]
    super("id/#{id}")
  end

  protected

  def map_resources(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = @favorites&.find { |fav| fav.item_id == String(res["tiss_id"]) }&.id
        map_resource(res, favorite, false)
      end
    end
  end

  def map_resource(res, favorite, is_single)
    id = res["tiss_id"] || " "
    Resource.new(
      id,
      res["first_name"] + " " + res["last_name"],
      nil,
      nil,
      person_path(id),
      favorite,
      Favorite.favorite_types["person"]
    )
  end
end
