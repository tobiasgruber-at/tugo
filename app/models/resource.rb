class Resource
  include ActiveModel::API

  attr_accessor :id, :title, :_prefix, :addition, :path, :favorite, :favorite_type, :keywords

  def is_favorite?
    not @favorite.nil?
  end
end
