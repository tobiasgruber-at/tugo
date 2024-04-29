class Resource
  attr_accessor :id, :title, :_prefix, :addition, :path, :is_favorite, :favorite_type

  def initialize(id, title, prefixx, addition, path, is_favorite, favorite_type)
    @id = id
    @title = title
    @_prefix = prefixx
    @addition = addition
    @path = path
    @is_favorite = is_favorite
    @favorite_type = favorite_type
  end
end