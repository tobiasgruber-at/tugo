class ThesesController < TissApiController

  def index
    @search_term = SearchTerm.new(search_params)
    super("search/thesis/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  def show
    @id = params["id"]
    super("thesis/#{@id}", -> (val) { Nokogiri::XML(val) })
  end
end
