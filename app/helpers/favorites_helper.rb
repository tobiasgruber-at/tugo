module FavoritesHelper
  def favorite(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources.map do |res|
        id = res["id"] || ""
        Resource.new(
          id,
          res["preview"],
          nil,
          nil,
          favorite_path(id),
          true,
          nil
        )
      end
    end
  end
end
