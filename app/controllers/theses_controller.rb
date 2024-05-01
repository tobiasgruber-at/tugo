class ThesesController < TissApiController

  def index
    term = params["term"]
    super(term,"search/thesis/v1.0/quickSearch?searchterm=#{term}")
  end

  def show
    @id = params["id"]
    super("thesis/#{@id}", -> (val) { Nokogiri::XML(val) })
  end
end
