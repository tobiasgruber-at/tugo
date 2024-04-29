class FavoritesController < ApplicationController
  def index
    @favorite_courses = Favorite.where(user_id: session[:user_id], favorite_type: Favorite.favorite_types["course"])
    @favorite_people = Favorite.where(user_id: session[:user_id], favorite_type: Favorite.favorite_types["person"])
    @favorite_theses = Favorite.where(user_id: session[:user_id], favorite_type: Favorite.favorite_types["thesis"])
    @favorite_projects = Favorite.where(user_id: session[:user_id], favorite_type: Favorite.favorite_types["project"])
  end

  def create
    # TODO: show error msg
    @favorite = Favorite.new(
      :user_id => session[:user_id],
      :item_id => favorite_params["item_id"],
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
