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

  def show(endpoint = "", parser = -> (val) { JSON.parse(val) })
    begin
      @resource = self.find(endpoint, parser)
    rescue StandardError => e
      flash.now[:alert] = "An error occurred. Please try again later."
    end
  end

  def index(endpoint = "", parser = -> (val) {JSON.parse(val)})
    if not @search_term.query.nil? and @search_term.valid?
      begin
        @resources = self.search(endpoint, parser)
        if has_error?(@resources)
          @resources = nil
        end
        @favorites = Favorite.where(user_id: session[:user_id])
      rescue StandardError => e
        @resources = nil
        flash.now[:alert] = "An error occurred. Please try again later."
      end
    end
  end

  def search_params
    params.require(:search_term).permit(:query) if params[:search_term]
  end

  private

  def search(endpoint, parser = -> (val) {JSON.parse(val)})
    uri = URI(base + endpoint)
    response = Net::HTTP.get(uri)
    parser.call(response)
  end

  def find(endpoint, parser)
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
