# @!attribute [r] favorites
#   @return [Favorite[]] a list of favorites
# @!attribute [r] favorite
#   @return [Favorite] the newly created favorite model (see {#create})
class FavoritesController < TissApiController

  # Shows a list of all favorites.
  #
  # After a call to this method, the {#favorites} instance variable will be set.
  #
  # @return [void]
  def index
    begin
      @favorites = sort(Favorite.where(user_id: session[:user_id]))
      @report_option = ReportOption.new
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

  # Adds a new favorite.
  #
  # After a call to this method, the {#favorite} instance variable will be set.
  #
  # @return [void]
  def create
    is_error = false
    begin
      @favorite = Favorite.new(
        user_id: session[:user_id],
        item_id: favorite_params["item_id"],
        preview: favorite_params["preview"],
        favorite_type: Integer(favorite_params["favorite_type"])
      )
      unless @favorite.valid? && @favorite.save
        is_error = true
      end
    rescue StandardError => e
      puts e.message
      is_error = true
    end
    if is_error
      redirect_back fallback_location: favorites_path, alert: "An error occurred. Please try again later."
    else
      redirect_back fallback_location: favorites_path(anchor: "favorites-sort-options")
    end
  end

  def update
    is_error = false
    begin
      @favorite = Favorite.find(params[:id])
      unless @favorite.valid? && @favorite.update(update_favorite_params)
        is_error = true
      end
    rescue StandardError => e
      puts e.message
      is_error = true
    end
    if is_error
      redirect_back fallback_location: favorites_path, alert: "An error occurred. Please try again later."
    else
      redirect_back fallback_location: favorites_path(anchor: "favorites-sort-options")
    end
  end

  # Removes a favorite.
  #
  # @return [void]
  def destroy
    begin
      Favorite.destroy(params[:id])
      redirect_back fallback_location: favorites_path
    rescue StandardError => e
      puts e.message
      redirect_back fallback_location: favorites_path, alert: "An error occurred. Please try again later."
    end
  end

  protected

  def map_resources(favorites, path_selector_fn)
    if favorites.nil? || favorites.empty?
      []
    else
      favorites.map do |fav|
        path = path_selector_fn.call(fav["item_id"])
        map_resource(fav, path)
      end
    end
  end

  def map_resource(fav, path)
    id = fav["id"] || ""
    Resource.new(
      id: id,
      title: fav["preview"],
      _prefix: nil,
      addition: nil,
      path: path,
      favorite: fav,
      favorite_type: nil,
      keywords: nil
    )
  end

  private

  def sort(resources)
    @sort_option = SortOption.new(sort_params)
    case (@sort_option.target)
    when :title
      return resources.order(preview: @sort_option.direction)
    when :date
      return resources.order(created_at: @sort_option.direction)
    else
      return resources.order(:preview)
    end
  end

  def favorite_params
    params.require(:favorite).permit(:item_id, :preview, :favorite_type, :note)
  end

  def update_favorite_params
    params.require(:favorite).permit(:note)
  end

  def sort_params
    params.require(:sort_option).permit(:target, :direction) if params[:sort_option]
  end

end
