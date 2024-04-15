module CoursesHelper
  def course_number(result)
    course_field(result, 0)
  end

  def course_type(result)
    course_field(result, 1)
  end

  def course_name(result)
    course_field(result, 2)
  end

  def course_semester(result)
    course_field(result, 3)
  end

  private

  def course_field(result, index)
    title = result["title"].to_s
    fields = parse_course_title(title)
    fields[index]
  end

  def parse_course_title(title)
    pattern = /^([0-9A-Z.]+) ([A-Z]{2}) (.*?), ([0-9]{4}[S|W]?)$/
    title.scan(pattern)[0]
  end
end
