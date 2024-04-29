module ThesesHelper
  def map_theses(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_thesis(res, favorites) }
    end
  end

  def map_thesis(res, favorites = nil)
    id = res["id"] || ""
    Resource.new(
      id,
      res["title"],
      nil,
      nil,
      thesis_path(id),
      favorites.nil? ? false : (favorites.any? { |fav| fav.item_id == String(id) }),
      Favorite.favorite_types["thesis"]
    )
  end
end
