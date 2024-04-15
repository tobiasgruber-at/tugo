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
    termModel = SearchTerm.new(query: @term)
    unless termModel.valid?
      @error = "Term #{termModel.errors.messages[:query][0]}"
      return
    end
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    @resources = JSON.parse(response)
    if @resources['error_message']
      @error = @resources['error_message']
    end
    puts @resources
  end

  def show(endpoint = "", parser = -> (val) { JSON.parse(val) })
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    @resource = parser.call(response)
    puts @resource
  end

end
