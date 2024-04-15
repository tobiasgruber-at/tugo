require 'net/http'
require 'json'

class ApplicationController < ActionController::Base

  URI_BASE = "https://tiss.tuwien.ac.at/api/"

  def initialize
    @endpoint_base = ""
  end

  def base
    URI_BASE + @endpoint_base
  end

  def index(endpoint = "")
    @term = params["term"]
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    @resources = JSON.parse(response)
  end

  def show(endpoint = "")
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    @resource = JSON.parse(response)
  end

end
