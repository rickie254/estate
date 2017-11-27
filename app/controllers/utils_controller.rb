class UtilsController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def sitemap
    redirect_to "http://zordanimoveis-production.s3.amazonaws.com/sitemap.xml.gz"
  end

  def get_stats
    stats = []
    doc = Nokogiri::HTML(open(STATS_URL))

    latest_record = doc.css('#quotation ul li')

    if latest_record.length > 0
      latest_record.each do |li|
        record = {}
        record[:name] = li.css('strong')[0].content
        record[:month] = li.css('span')[0].content
        record[:value] = li.css('span')[1].content
        stats << record
      end
    end

    if stats.length > 0
      render json: stats
    else
      head :not_found
    end

  end

  def get_available_properties
    data = {
      apartments: Apartment.any?,
      houses: House.any?,
      comercials: Comercial.any?,
      terrains: Terrain.any?
    }

    render json: data
  end
end
