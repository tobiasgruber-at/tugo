# This is a {https://tiss.tuwien.ac.at TISS} API controller for people.
class PeopleController < TissApiController

  def initialize
    super
    @endpoint_base = "person/v22/"
  end

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["person"], "psuche?q=#{@search_term.query}&max_treffer=100")
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
        favorite = @favorites&.find { |fav| fav.item_id == String(res["tiss_id"]) }
        map_resource(res, favorite, false)
      end
    end
  end

  def map_resource(res, favorite, is_single, keywords = nil)
    id = res["tiss_id"] || " "
    Person.new(
      id: id,
      title: res["first_name"] + " " + res["last_name"],
      _prefix: nil,
      addition: nil,
      path: person_path(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["person"],
      keywords: keywords,
      titles_pre: res["preceding_titles"],
      titles_post: res["postpositioned_titles"],
      email: res["main_email"]
    )
  end
end
