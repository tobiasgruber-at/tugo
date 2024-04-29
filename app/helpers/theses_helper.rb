module ThesesHelper
  def theses(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        id = res["id"] || ""
        Resource.new(
          id,
          res["title"],
          nil,
          nil,
          thesis_path(id),
          favorites.any? { |fav| fav.item_id == String(id) },
          Favorite.favorite_types["thesis"]
        )
      end
    end
  end
end
