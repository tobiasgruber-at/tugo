class ThesesController < TissApiController

  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["thesis"], "search/thesis/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  def show
    @id = params["id"]
    super("thesis/#{@id}", -> (val) { Nokogiri::XML(val) })
  end

  def self.map_theses(resources, favorites, path_selector_fn)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = favorites&.find { |fav| fav.item_id == String(res["id"]) }
        ThesesController.map_thesis(res, favorite, false, path_selector_fn, nil)
      end
    end
  end

  def self.map_thesis(res, favorite, is_single, path_selector_fn, id, keywords = nil)
    if is_single
      res.remove_namespaces!
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
      path: path_selector_fn.call(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["thesis"],
      keywords: keywords,
      institute: institute,
      faculty: faculty,
      thesis_keywords: thesis_keywords,
      url: url,
    )
  end

  protected

  def map_resources(resources)
    ThesesController.map_theses(resources, @favorites, -> (id) { thesis_path(id) })
  end

  def map_resource(res, favorite, is_single, keywords = nil)
    ThesesController.map_thesis(res, favorite, is_single, -> (id) { thesis_path(id) }, @id, keywords)
  end
end
