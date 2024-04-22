module ProjectsHelper
  def projects(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"]
    end
  end
end
