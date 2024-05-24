class Resource
  include ActiveModel::API
  
  attr_accessor :id, :title, :_prefix, :addition, :path, :favorite_id, :favorite_type, :keywords

  def is_favorite?
    not @favorite_id.nil?
  end
end
