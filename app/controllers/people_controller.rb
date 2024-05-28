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
    @id = params["id"]
    super("id/#{@id}")
  end

  def self.map_people(resources, favorites, path_selector_fn)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = @favorites&.find { |fav| fav.item_id == String(res["tiss_id"]) }
        PeopleController.map_person(res, favorite, false, path_selector_fn, nil)
      end
    end
  end

  def self.map_person(res, favorite, is_single, path_selector_fn, id, keywords = nil)
    id = res["tiss_id"] || " "
    Person.new(
      id: id,
      title: res["first_name"] + " " + res["last_name"],
      _prefix: nil,
      addition: nil,
      path: path_selector_fn.call(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["person"],
      keywords: keywords,
      titles_pre: res["preceding_titles"],
      titles_post: res["postpositioned_titles"],
      email: res["main_email"]
    )
  end

  protected

  def map_resources(resources)
    PeopleController.map_people(resources, @favorites, -> (id) { person_path(id) })
  end

  def map_resource(res, favorite, is_single, keywords = nil)
    PeopleController.map_person(res, favorite, is_single, -> (id) { person_path(id) }, @id, keywords)
  end
end
