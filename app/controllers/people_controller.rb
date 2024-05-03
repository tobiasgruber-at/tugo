class PeopleController < TissApiController

  def initialize
    super
    @endpoint_base = "person/v22/"
  end

  def index
    @search_term = SearchTerm.new(search_params)
    super("psuche?q=#{@search_term.query}&max_treffer=100")
  end

  def show
    id = params["id"]
    super("id/#{id}")
  end
end
