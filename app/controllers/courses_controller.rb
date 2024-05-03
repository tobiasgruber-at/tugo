class CoursesController < TissApiController

  def index
    @search_term = SearchTerm.new(course_params)
    super("search/course/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  def show
    @id = params["id"]
    super("course/#{@id}", -> (val) { Nokogiri::XML(val) })
  end

  def course_params
    params.require(:search_term).permit(:query)
  end
end
