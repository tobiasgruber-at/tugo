module ThesesHelper
  def map_theses(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_thesis(res, favorites) }
    end
  end

  def map_thesis(res, favorites = nil, is_json = true)
    if is_json
      id = res["id"] || ""
      title = res["title"]
    else
      id = @id
      title = res.css("title *:last-of-type").text
    end
    Resource.new(
      id,
      title,
      nil,
      nil,
      thesis_path(id),
      favorites.nil? ? nil : favorites.find { |fav| fav.item_id == String(id) },
      Favorite.favorite_types["thesis"]
    )
  end
end
