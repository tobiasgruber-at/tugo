class PeopleController < ApplicationController
  def initialize
    @endpoint_base = "person/v22/"
    super
  end

  def index
    super("psuche?q=#{params['term']}&max_treffer=50")
  end
  ##
  # require "addressable/uri"
  #
  # url = Addressable::URI.parse('http://www.example.com?id=4&empid=6')
  # url.query_values                  # {"id"=>"4", "empid"=>"6"}
  # id    = url.query_values['id']    # "4"
  # empid = url.query_values['empid'] # "6"

  def show
    super("id/")
  end
end
