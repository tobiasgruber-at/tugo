module PeopleHelper
  def people(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        id = res["tiss_id"] || " "
        Resource.new(
          id,
          nil,
          res["first_name"] + " " + res["last_name"],
          nil,
          person_path(id),
          favorites.any? { |fav| fav.item_id == String(id) },
          Favorite.favorite_types["person"]
        )
      end
    end
  end
end
