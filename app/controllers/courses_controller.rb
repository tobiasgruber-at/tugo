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

  # Maps many courses to resources
  #
  # @param resources Resources to be mapped
  # @param favorites All favorites of the user
  # @param path_selector_fn Selects the details path for each single item
  # @return [void]
  def self.map_courses(resources, favorites, path_selector_fn)
    if resources.nil? || resources["results"].nil? || resources.empty?
      []
    else
      resources["results"].map do |res|
        favorite = favorites&.find { |fav| fav.item_id == String(course_id(res)) }
        CoursesController.map_course(res, favorite, false, path_selector_fn, nil)
      end
    end
  end

  # Maps one course to a resource
  #
  # @param res The fetched course
  # @param favorite Favorite object, or null if it is no favorite
  # @param is_single Whether it was fetched in a list, or as a single item
  # @param path_selector_fn Selects the details path
  # @param id ID of the course
  # @param keywords Added keywords for this course
  # @return [void]
  def self.map_course(res, favorite, is_single, path_selector_fn, id, keywords = nil)
    if is_single
      res.remove_namespaces!
      title = res.css("title *:last-of-type").text
      prefix = res.css("courseType").text
      addition = res.css("courseNumber").text
    else
      id = CoursesController.course_id(res)
      title = CoursesController.course_field(res, 2)
      prefix = CoursesController.course_field(res, 1)
      addition = CoursesController.course_field(res, 0)
    end
    Course.new(
      id: id,
      title: title,
      _prefix: prefix,
      addition: addition,
      path: path_selector_fn.call(id),
      favorite: favorite,
      favorite_type: Favorite.favorite_types["course"],
      keywords: keywords
    )
  end

  protected

  # @see TissApiController#map_resources
  def map_resources(resources)
    CoursesController.map_courses(resources, @favorites, -> (id) { course_path(id) })
  end

  # @see TissApiController#map_resource
  def map_resource(res, favorite, is_single, keywords = nil)
    CoursesController.map_course(res, favorite, is_single, -> (id) { course_path(id) }, @id, keywords)
  end

  private

  # Extracts the course id of a course response.
  #
  # @return Course id
  def self.course_id(course)
    course_nr = course["detail_url"].match(/courseNr=([\dA-Za-z]+(\.\d+)?)/)[1]
    semester = course["detail_url"].match(/semester=(\d+\w)/)[1]
    "#{course_nr}-#{semester}"
  end

  # Gets a given field from the course
  #
  # @return The fields' value
  def self.course_field(course, index)
    title = course["title"].to_s
    fields = parse_course_title(title)
    fields[index]
  end

  # Parses the course title
  #
  # @return Course title
  def self.parse_course_title(title)
    pattern = /^([0-9A-Z.]+) ([A-Z]{2}) (.*?), ([0-9]{4}[S|W]?)$/
    title.scan(pattern)[0]
  end
end
