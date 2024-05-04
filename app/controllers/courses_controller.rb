# This is a {https://tiss.tuwien.ac.at TISS} API controller for courses.
class CoursesController < TissApiController

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super("search/course/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  # @see TissApiController#see
  def show
    @id = params["id"]
    super("course/#{@id}", -> (val) { Nokogiri::XML(val) })
  end
end
