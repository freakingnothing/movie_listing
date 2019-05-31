module Scraper
  class BaseScraper
    require 'rest-client'
    require 'nokogiri'

    attr_accessor :url, :page, :info

    def initialize(url)
      @url = url
    end

    def get_page(url)
      @page = Nokogiri::HTML(RestClient.get(url))
    end
  end
end
