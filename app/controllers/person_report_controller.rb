class PersonReportController < TissApiController
  def show
    @search_term = params[:id]
    @favorites = Favorite.where(user_id: session[:user_id])
    @courses = CoursesController.map_courses(
      search("search/course/v1.0/quickSearch?searchterm=#{@search_term}"),
      @favorites,
      -> (id) { course_path(id) }
    )
    @projects = ProjectsController.map_projects(
      search("search/projectFullSearch/v1.0/projects?searchterm=#{@search_term}"),
      @favorites,
      -> (id) { project_path(id) }
    )
    @theses = ThesesController.map_theses(
      search("search/thesis/v1.0/quickSearch?searchterm=#{@search_term}"),
      @favorites,
      -> (id) { thesis_path(id) }
    )
  end
end
