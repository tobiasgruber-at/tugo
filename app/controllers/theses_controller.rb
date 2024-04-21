class ThesesController < TissApiController

  def index
    super("search/thesis/v1.0/quickSearch?searchterm=#{params["term"]}")
  end

  def show
    super("thesis/#{params["id"]}", -> (val) { Nokogiri::XML(val) })
  end
end
