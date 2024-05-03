module PeopleHelper
  def map_people(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_person(res, favorites) }
    end
  end

  def map_person(res, favorites = nil)
    id = res["tiss_id"] || " "
    Resource.new(
      id,
      res["first_name"] + " " + res["last_name"],
      nil,
      nil,
      person_path(id),
      favorites.nil? ? nil : favorites.find { |fav| fav.item_id == String(id) },
      Favorite.favorite_types["person"]
    )
  end
end
