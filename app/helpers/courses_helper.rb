module CoursesHelper
  # Maps many courses to resource objects.
  def map_courses(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_course(res, favorites) }
    end
  end

  # Maps a course to a resource object.
  def map_course(res, favorites = nil, is_json = true)
    if is_json
      course_nr = res["detail_url"].match(/courseNr=(\d+)/)[1]
      semester = res["detail_url"].match(/semester=(\d+\w)/)[1]
      id = "#{course_nr}-#{semester}"
      title = course_field(res, 2)
      prefix = course_field(res, 1)
      addition = course_field(res, 0)
    else
      @resource.remove_namespaces!
      id = @id
      title = @resource.css("title *:last-of-type").text
      prefix = @resource.css("courseType").text
      addition = @resource.css("courseNumber").text
    end
    Resource.new(
      id,
      title,
      prefix,
      addition,
      course_path(id),
      favorites.nil? ? nil : favorites.find { |fav| fav.item_id == String(id) },
      Favorite.favorite_types["course"]
    )
  end

  private

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
