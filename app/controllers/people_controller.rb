class PeopleController < ApplicationController

  def initialize
    super
    @endpoint_base = "person/v22/"
  end
  
  def index
    super("psuche?q=#{params["term"]}&max_treffer=100")
    ##
    # require "addressable/uri"
    #
    # url = Addressable::URI.parse('http://www.example.com?id=4&empid=6')
    # url.query_values                  # {"id"=>"4", "empid"=>"6"}
    # id    = url.query_values['id']    # "4"
    # empid = url.query_values['empid'] # "6"
  end

  def show
    id = params["id"]
    super("id/#{id}")
  end
end
