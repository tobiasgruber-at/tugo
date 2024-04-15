class ProjectsController < ApplicationController

  def index
    super("search/projectFullSearch/v1.0/projects?searchterm=#{params["term"]}")
  end

  def show
    super("pdb/rest/project/v3/#{params["id"]}", -> (val) { Nokogiri::XML(val) })
  end
end
