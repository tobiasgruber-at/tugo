module ProjectsHelper
  # Maps many projects to resource objects.
  def map_projects(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_project(res, favorites) }
    end
  end

  # Maps a project to a resource object.
  def map_project(res, favorites = nil, is_json = true)
    if is_json
      id = res["id"] || ""
      title = res["title"]
    else
      @resource.remove_namespaces!
      id = @id
      title = res.css("title en").text
    end
    Resource.new(
      id,
      title,
      nil,
      nil,
      project_path(id),
      favorites.nil? ? nil : favorites.find { |fav| fav.item_id == String(id) },
      Favorite.favorite_types["project"]
    )
  end
end
