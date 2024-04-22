module PeopleHelper

  def people(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"]
    end
  end

  def full_name(result)
    result["first_name"] + " " + result["last_name"]
  end
end
