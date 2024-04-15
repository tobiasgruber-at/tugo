class ProjectsController < ApplicationController

  def index
    super("search/projectFullSearch/v1.0/projects?searchterm=#{params["term"]}")
    # TODO: capture result and parse course number and semester
  end

  def show
    super("pdb/rest/project/v3/#{params["id"]}")
  end
end
