class FavoritesReportController < TissApiController
  layout "report"

  def index
    begin
      @favorites = Favorite.where(user_id: session[:user_id]).order(preview: :asc)
      @report_option = ReportOption.new(report_options_params)
      @favorite_courses = map_resources(
        @favorites&.filter { |fav| fav.favorite_type == "course" },
        -> (id) { course_path(id) }
      )
      @favorite_people = map_resources(
        @favorites&.filter { |fav| fav.favorite_type == "person" },
        -> (id) { person_path(id) }
      )
      @favorite_theses = map_resources(
        @favorites&.filter { |fav| fav.favorite_type == "thesis" },
        -> (id) { thesis_path(id) }
      )
      @favorite_projects = map_resources(
        @favorites&.filter { |fav| fav.favorite_type == "project" },
        -> (id) { project_path(id) }
      )
    rescue StandardError => e
      puts e.message
      @favorites = nil
      flash.now[:alert] = "An error occurred. Please try again later."
    end
  end

  def map_resources(favorites, path_selector_fn)
    if favorites.nil? || favorites.empty?
      []
    else
      favorites.map do |fav|
        id = fav["item_id"]
        path = path_selector_fn.call(id)
        keywords = fav.nil? ? nil : Keyword.where(favorite_id: fav["id"])
        map_resource(fav, path, keywords)
      end
    end
  end

  def map_resource(fav, path, keywords)
    id = fav["id"] || ""
    Resource.new(
      id: id,
      title: fav["preview"],
      _prefix: nil,
      addition: nil,
      path: path,
      favorite: fav,
      favorite_type: nil,
      keywords: keywords
    )
  end

  private

  def report_options_params
    params.require(:report_option).permit(:show_notes, :show_keywords) if params[:report_option]
  end
end
