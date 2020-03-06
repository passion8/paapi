require 'json'

module Paapi
  class Response
    attr_reader :http_response, :hash, :datas, :doc, :items

    def initialize(response)
      @http_response = response
      @hash = JSON.parse(response.body.to_s)
      @items_data =  @hash["ItemsResult"]["Items"]
      @items_data ||= @hash['SearchResult']['Items']
      @items_data ||= @hash['VariationsResult']['Items']
      @items_data ||= []

      @items = @items_data.map {|d| Item.new(d)}

    end

    def result_count
      @hash['SearchResult']['TotalResultCount']
    end
  end
end