module ProjectsHelper
  def map_projects(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_project(res, favorites) }
    end
  end

  def map_project(res, favorites = nil)
    id = res["id"] || ""
    Resource.new(
      id,
      res["title"],
      nil,
      nil,
      project_path(id),
      favorites.nil? ? false : (favorites.any? { |fav| fav.item_id == String(id) }),
      Favorite.favorite_types["project"]
    )
  end
end
