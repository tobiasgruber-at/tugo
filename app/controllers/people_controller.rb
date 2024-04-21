class PeopleController < TissApiController

  def initialize
    super
    @endpoint_base = "person/v22/"
  end

  def index
    term = params["term"]
    super(term,"psuche?q=#{term}&max_treffer=100")
  end

  def show
    id = params["id"]
    super("id/#{id}")
  end
end
