module FavoritesHelper
  # Maps many favorites to resource objects.
  def map_favorites(resources, path_selector_fn)
    if resources.nil? || resources.empty?
      []
    else
      resources.map { |res| map_favorite(res, path_selector_fn) }
    end
  end

  # Maps a favorite to a resource object.
  def map_favorite(res, path_selector_fn)
    id = res["id"] || ""
    Resource.new(
      id,
      res["preview"],
      nil,
      nil,
      path_selector_fn.call(res["item_id"]),
      id,
      nil
    )
  end
end
