class CoursesController < TissApiController

  def index
    term = params["term"]
    super("search/course/v1.0/quickSearch?searchterm=#{term}")
  end

  def show
    course_number = params["course_number"]
    semester = params["semester"]
    super("course/#{course_number}-#{semester}")
  end
end
