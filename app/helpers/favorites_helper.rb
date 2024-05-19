module FavoritesHelper

  def sort_direction
    params["sort_direction"] == "desc" ? :desc : :asc
  end

  def sort_by
    params["sort_by"]
  end

end
