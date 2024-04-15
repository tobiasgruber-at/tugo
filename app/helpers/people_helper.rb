module PeopleHelper
  def full_name(result)
    result["first_name"] + " " + result["last_name"]
  end
end
