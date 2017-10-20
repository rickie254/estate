class String
  def comma_to_delimiter
    gsub('.', '').gsub(',', '.').to_f
  end
end
