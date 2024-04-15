class ThesesController < ApplicationController

  def index
    super("search/thesis/v1.0/quickSearch?searchterm=#{params["term"]}")
  end

  def show
    super("thesis/#{params["id"]}")
  end
end
