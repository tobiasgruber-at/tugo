class CoursesController < TissApiController

  def index
    term = params["term"]
    super(term,"search/course/v1.0/quickSearch?searchterm=#{term}")
  end

  def show
    @id = params["id"]
    super("course/#{@id}", -> (val) { Nokogiri::XML(val) })
  end
end
