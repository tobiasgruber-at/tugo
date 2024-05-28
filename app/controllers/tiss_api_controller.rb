require 'net/http'
require 'json'

# This controller provides functionality to operate on the {https://tiss.tuwien.ac.at TISS} API. Specifically for searching
# for resources by a query term and getting a single resource.
#
# The subclassed implementation might override the {endpoint_base} instance variable to provide a common URI base for
# all calls from that implementation. Similarly, the base URI for the {https://tiss.tuwien.ac.at TISS} API is already
# specified in this implementation and must be omitted.
#
# @abstract
#
# @!attribute [rw] endpoint_base
#   @return [String] the endpoint base for all API URIs of the class.
# @!attribute [rw] search_term
#   @return [String] the model of the current search
# @!attribute [r] URI_BASE
#   @return [String] endpoint base for all API URIs of this class
class TissApiController < ApplicationController

  # TODO: add YARD doc
  before_action :redirect_if_not_logged_in

  # Initializes a new object of this class.
  #
  # Sets {endpoint_base} to the empty string.
  # @return [void]
  def initialize
    @endpoint_base = ""
    super
  end

  # Shows the details of a single resource.
  #
  # Performs an call to the provided endpoint and parses the result with the given parser.
  # After a call to this function, the member `@resource` and `@favorites` will be set.
  #
  # @param [String] endpoint the endpoint that should be called
  # @param [Proc] parser a parser that can parse the API response
  # @return [void]
  def show(endpoint = "", parser = -> (val) { JSON.parse(val) })
    begin
      res = self.search(endpoint, parser)
      favorite = Favorite.find_by(item_id: @id.to_s, user_id: session[:user_id])
      keywords = favorite.nil? ? nil : Keyword.where(favorite_id: favorite)
      @resource = map_resource(res, favorite, true, keywords)
    rescue StandardError => e
      puts e.message
      flash.now[:alert] = "An error occurred. Please try again later."
    end
  end

  # Shows the list of all resources filtered by a search term.
  #
  # Performs an call to the provided endpoint and parses the result with the given parser.
  # Before this function can be called the member variable @search_term has to be set. This can be done with the
  # function {#search_params}. If the query is `nil`, no search will be performed.
  # After the call to this function, the members `@resources` and `@favorites` will be set.
  #
  # @see #search_params
  # @param [String] endpoint the endpoint that should be called
  # @param [Proc] parser a parser that can parse the API response
  # @return [void]
  def index(favorite_type, endpoint = "", parser = -> (val) { JSON.parse(val) })
    if not @search_term.query.nil? and @search_term.valid?
      begin
        res = self.search(endpoint, parser)
        if has_error?(res)
          @resources = nil
        else
          @favorites = Favorite.where(user_id: session[:user_id], favorite_type: favorite_type)
          @resources = map_resources(res)
        end
      rescue StandardError => e
        puts e.message
        @resources = nil
        flash.now[:alert] = "An error occurred. Please try again later."
      end
    end
  end

  protected

  # Maps many courses to resource objects.
  def map_resources(resources)
    throw NotImplementedError "Should be implemented in child class"
  end

  # Maps a fetched resource to a uniform format
  def map_resource(res, favorites, is_single, keywords = nil)
    throw NotImplementedError "Should be implemented in child class"
  end

  private

  # All API calls have this common base URI
  URI_BASE = "https://tiss.tuwien.ac.at/api/"

  # Gets the base URI for the API call.
  #
  # The URI is generated from the common URI base and the endpoint base {endpoint_base}.
  #
  # @return [String] the base URI for the API call
  def base
    URI_BASE + @endpoint_base
  end

  # Gets the parameters for the search query
  #
  # @return [ActionController::Parameters] the parameter object for the search query, if any search term is given
  def search_params
    params.require(:search_term).permit(:query) if params[:search_term]
  end

  def search(endpoint, parser = -> (val) { JSON.parse(val) })
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
