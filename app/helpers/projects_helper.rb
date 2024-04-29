module ProjectsHelper
  def projects(resources, favorites)
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
          project_path(id),
          favorites.any? { |fav| fav.item_id == String(id) },
          Favorite.favorite_types["project"]
        )
      end
    end
  end
end
