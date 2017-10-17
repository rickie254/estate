class Apartment < Property
  include Building
  monetize :condominium_cents

  enum number_of_rooms: [ :kitnet, :one, :two, :three, :four_or_more ]
end
