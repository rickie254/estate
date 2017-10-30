class UtilsController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def get_stats
    stats = []
    doc = Nokogiri::HTML(open('http://www.bolsapar.com.br/'))

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
end
