require 'net/http'
require 'json'

class TissApiController < ApplicationController
  before_action :redirect_if_logged_in

  URI_BASE = "https://tiss.tuwien.ac.at/api/"

  def initialize
    @endpoint_base = ""
    super
  end

  def base
    URI_BASE + @endpoint_base
  end

  def index(term, endpoint = "", parser = -> (val) {JSON.parse(val)})
    @term = term
    begin
      self.validate_term
      @resources = self.search(endpoint, parser)
    rescue RuntimeError => e
      @error = e.message
      @resources = nil
    end
  end

  def show(endpoint = "", parser = -> (val) { JSON.parse(val) })
    @resource = self.get(endpoint, parser)
    puts @resource
  end

  private

  def validate_term
    term_model = SearchTerm.new(query: @term)
    unless term_model.valid?
      # TODO: add custom error
      raise RuntimeError.new("Term #{term_model.errors.messages[:query][0]}")
    end
  end

  def search(endpoint, parser)
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    resources = parser.call(response)
    if has_error?(resources)
      # TODO: add custom error
      raise RuntimeError.new(resources['error_message'])
    end
    resources
  end

  def get(endpoint, parser)
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    parser.call(response)
  end

  def has_error?(resources)
    not get_error_msg(resources).nil?
  end

  def get_error_msg(resources)
    resources['error_message']
  end

end
