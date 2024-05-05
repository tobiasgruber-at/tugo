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
      @favorites = Favorite.where(user_id: session[:user_id])
      empty = @favorites.nil? || @favorites.empty?
      @favorite_courses = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "course" }
      @favorite_people = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "person" }
      @favorite_theses = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "thesis" }
      @favorite_projects = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "project" }
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
        :user_id => session[:user_id],
        :item_id => favorite_params["item_id"],
        :preview => favorite_params["preview"],
        :favorite_type => Integer(favorite_params["favorite_type"])
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
      redirect_back fallback_location: favorites_path
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

  private

  def favorite_params
    params.require(:favorite).permit(:item_id, :preview, :favorite_type, :note)
  end

end
