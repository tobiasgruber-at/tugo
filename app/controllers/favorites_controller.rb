class FavoritesController < TissApiController
  def index
    @favorites = Favorite.where(user_id: session[:user_id])
    empty = @favorites.nil? || @favorites.empty?
    @favorite_courses = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "course" }
    @favorite_people = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "person" }
    @favorite_theses = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "thesis" }
    @favorite_projects = empty ? [] : @favorites.filter { |fav| fav.favorite_type == "project" }
  end

  def create
    # TODO: show error msg
    @favorite = Favorite.new(
      :user_id => session[:user_id],
      :item_id => favorite_params["item_id"],
      # TODO: add real text
      :preview => "Yet another favorite item",
      :favorite_type => Integer(favorite_params["favorite_type"])
    )
    begin
      if @favorite.valid? && @favorite.save
        puts "saved"
      else
        @error = "Invalid"
      end
    rescue StandardError => e
      @error = e.message
    end
    @error = "this is an error"
    redirect_to favorites_path
  end

  def update
    # update favorite
  end

  def destroy
    # destroy
  end

  def favorite_params
    params.require(:favorite).permit(:item_id, :favorite_type, :note)
  end

end
