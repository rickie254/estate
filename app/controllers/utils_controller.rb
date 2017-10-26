class UtilsController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def get_incc
    incc = {}
    doc = Nokogiri::HTML(open('http://www.calculador.com.br/tabela/indice/INCC'))
    latest_record = doc.css('#tabela-indice tbody tr')[0]
    if latest_record
      incc[:month] = latest_record.css('td')[0].content
      incc[:value] = latest_record.css('td')[1].content
      incc[:acumulated_year] = latest_record.css('td')[2].content
      incc[:acumulated_twelve_months] = latest_record.css('td')[3].content
      
      render json: {incc: incc}
    else
      head :not_found
    end

  end
end
