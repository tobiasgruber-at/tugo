module CoursesHelper

  def courses(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"]
    end
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
