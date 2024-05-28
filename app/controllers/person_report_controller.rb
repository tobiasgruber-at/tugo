class PersonReportController < TissApiController
  def show
    begin
      @id = params[:id]
      @favorites = Favorite.where(user_id: session[:user_id])
      @person = PeopleController.map_person(
        search("person/v22/id/#{@id}"),
        @favorites&.find { |fav| fav.item_id == String(@id) },
        true,
        -> (id) {person_path(id)},
        @id
      )
      unless @person.nil?
        @courses = CoursesController.map_courses(
          search("search/course/v1.0/quickSearch?searchterm=#{@person.title}"),
          @favorites,
          -> (id) { course_path(id) }
        )
        @projects = ProjectsController.map_projects(
          search("search/projectFullSearch/v1.0/projects?searchterm=#{@person.title}"),
          @favorites,
          -> (id) { project_path(id) }
        )
        @theses = ThesesController.map_theses(
          search("search/thesis/v1.0/quickSearch?searchterm=#{@person.title}"),
          @favorites,
          -> (id) { thesis_path(id) }
        )
      end
    rescue StandardError => e
      puts e.message
      flash.now[:alert] = "An error occurred. Please try again later."
    end
  end
end
