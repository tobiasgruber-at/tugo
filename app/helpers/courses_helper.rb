module CoursesHelper
  def map_courses(resources, favorites)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"].map { |res| map_course(res, favorites) }
    end
  end

  def map_course(res, favorites = nil)
    id = res["id"] || " "
    Resource.new(
      id,
      course_name(res),
      course_type(res),
      course_number(res),
      course_path(id),
      favorites.nil? ? false : (favorites.any? { |fav| fav.item_id == String(id) }),
      Favorite.favorite_types["course"]
    )
  end

  def course_number(course)
    course_field(course, 0)
  end

  def course_type(course)
    course_field(course, 1)
  end

  def course_name(course)
    course_field(course, 2)
  end

  def course_semester(course)
    course_field(course, 3)
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
