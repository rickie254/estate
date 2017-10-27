class Apartment < Property
  include Building

  monetize :condominium_cents, allow_nil: true
  enum number_of_rooms: [ :kitnet, :one, :two, :three, :four ]

  def self.query_for_listing filter
    if filter
      if filter[:number_of_rooms]
        where(number_of_rooms: filter[:number_of_rooms])
      elsif filter[:number_of_boxes]
        where("number_of_boxes > ?", 0)
      elsif filter[:roof]
        where(roof: true)
      end
    else
      all
    end
  end

end
