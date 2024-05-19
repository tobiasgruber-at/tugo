class Resource
  attr_accessor :id, :title, :_prefix, :addition, :path, :favorite_id, :favorite_type, :keywords

  def initialize(id, title, prefix, addition, path, favorite_id, favorite_type, keywords)
    @id = id
    @title = title
    @_prefix = prefix
    @addition = addition
    @path = path
    @favorite_id = favorite_id
    @favorite_type = favorite_type
    @keywords = keywords
  end

  def is_favorite?
    not @favorite_id.nil?
  end
end
