module ThesesHelper
  def theses(resources)
    if resources.nil? || resources.empty?
      []
    else
      resources["results"]
    end
  end
end
