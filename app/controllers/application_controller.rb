require 'net/http'
require 'json'

class ApplicationController < ActionController::Base
  TISS_API_BASE = "https://tiss.tuwien.ac.at/api/"

  def index(endpoint)
    uri = URI(concat_uri(endpoint))
    response = Net::HTTP.get(uri)
    @resources = JSON.parse(response)
  end

  def show(endpoint)
    id = params[:id]
    uri = URI(concat_uri(endpoint, id))
    response = Net::HTTP.get(uri)
    @resource = JSON.parse(response)
  end

  private

  def concat_uri(endpoint = "", id = "")
    TISS_API_BASE + @endpoint_base + endpoint + id
  end


end
