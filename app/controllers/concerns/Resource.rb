class Resource
  attr_accessor :id, :title, :_prefix, :addition, :path, :favorite_id, :favorite_type

  def initialize(id, title, prefix, addition, path, favorite_id, favorite_type)
    @id = id
    @title = title
    @_prefix = prefix
    @addition = addition
    @path = path
    @favorite_id = favorite_id
    @favorite_type = favorite_type
  end
end