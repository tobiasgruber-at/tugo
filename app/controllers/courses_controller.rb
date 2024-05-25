# This is a {https://tiss.tuwien.ac.at TISS} API controller for courses.
class CoursesController < TissApiController

  # @see TissApiController#index
  def index
    @search_term = SearchTerm.new(search_params)
    super(Favorite.favorite_types["course"], "search/course/v1.0/quickSearch?searchterm=#{@search_term.query}")
  end

  # @see TissApiController#show
  def show
    @id = params["id"]
    super("course/#{@id}", -> (val) { Nokogiri::XML(val) })
  end

  protected

  def map_resources(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = @favorites&.find { |fav| fav.item_id == String(course_id(res)) }&.id
        map_resource(res, favorite, false)
      end
    end
  end

  def map_resource(res, favorite, is_single, keywords = nil)
    if is_single
      res.remove_namespaces!
      id = @id
      title = res.css("title *:last-of-type").text
      prefix = res.css("courseType").text
      addition = res.css("courseNumber").text
    else
      id = course_id(res)
      title = course_field(res, 2)
      prefix = course_field(res, 1)
      addition = course_field(res, 0)
    end
    Course.new(
      id: id,
      title: title,
      _prefix: prefix,
      addition: addition,
      path: course_path(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["course"],
      keywords: keywords
    )
  end

  private

  def course_id(course)
    course_nr = course["detail_url"].match(/courseNr=(\d+)/)[1]
    semester = course["detail_url"].match(/semester=(\d+\w)/)[1]
    "#{course_nr}-#{semester}"
  end

  def course_field(course, index)
    title = course["title"].to_s
    fields = parse_course_title(title)
    fields[index]
  end

  def parse_course_title(title)
    pattern = /^([0-9A-Z.]+) ([A-Z]{2}) (.*?), ([0-9]{4}[S|W]?)$/
    title.scan(pattern)[0]
  end
end
