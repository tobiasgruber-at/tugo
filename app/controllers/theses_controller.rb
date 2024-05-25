class ThesesController < TissApiController

  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["thesis"], "search/thesis/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  def show
    @id = params["id"]
    super("thesis/#{@id}", -> (val) { Nokogiri::XML(val) })
  end

  protected

  def map_resources(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = @favorites&.find { |fav| fav.item_id == String(res["id"]) }&.id
        map_resource(res, favorite, false)
      end
    end
  end

  def map_resource(res, favorite, is_single, keywords = nil)
    if is_single
      res.remove_namespaces!
      id = @id
      title = res.css("title *:last-of-type").text
      institute = "#{res.css("instituteCode").text} #{res.css("instituteName *:last-of-type").text}".strip
      faculty = "#{res.css("facultyCode").text} #{res.css("facultyName *:last-of-type").text}".strip
      thesis_keywords = res.css("keywords *:last-of-type").text
      url = res.css("url").text
    else
      id = res["id"] || ""
      title = res["title"]
      institute = "#{res["instituteCode"]} #{res["instituteName"]}".strip
      faculty = "#{res["facultyCode"]} #{res["facultyName"]}".strip
      thesis_keywords = res["keywords"]
      url = res["url"]
    end
    Thesis.new(
      id: id,
      title: title,
      _prefix: nil,
      addition: nil,
      path: thesis_path(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["thesis"],
      keywords: keywords,
      institute: institute,
      faculty: faculty,
      thesis_keywords: thesis_keywords,
      url: url,
    )
  end
end
